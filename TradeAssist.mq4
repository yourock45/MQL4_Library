//+------------------------------------------------------------------+
//|                                                  TradeAssist.mq4 |
//|                                                    Yury Talyukin |
//|                                                                  |
//+------------------------------------------------------------------+
#property library
#property copyright "Yury Talyukin"
#property link      ""
#property version   "1.00"
#property strict

// VARIABLES
datetime lastBarOpenTime = 0;
//+------------------------------------------------------------------+
//| Close All Orders                                                 |
//+------------------------------------------------------------------+
/*
   Close all Open and Pending orders.
   Returns true if completed successfully, false otherwise.
*/
   bool CloseAllOrders()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - CloseAllOrders: No orders to close");
         return true;
      }
      
      if(ClosePendingOrders() && CloseLiveOrders())
      {
         return true;
      }
      else
      {
         Print("TradeAssist - CloseAllOrders: Failed to close all orders");
         return false;
      }
   }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Close Pending Orders                                             |
//+------------------------------------------------------------------+
/*
   Close all pending orders.
   Returns true if successful, false otherwise.
*/
   bool ClosePendingOrders()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - ClosePendingOrders: No pending orders to close");
         return true;
      }
      CloseAllBuyLimit();
      CloseAllSellLimit();
      CloseAllBuyStop();
      CloseAllSellStop();
      
      return true;
   }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Close Live Orders                                                |
//+------------------------------------------------------------------+
/*
   Close all live orders.
   Returns true if successful, false otherwise.
*/
   bool CloseLiveOrders()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - CloseLiveOrders: No live orders to close");
         return true;
      }
      if(CloseAllBuy() && CloseAllSell())
      {
         return true;
      }
      else
      {
         Print("TradeAssist - CloseLiveOrders: Failed to close all live orders");
         return false;
      }
   }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Close All Buy                                                    |
//+------------------------------------------------------------------+
/*
   Close all Buy orders.
   Returns true if successful, false otherwise.
*/
   bool CloseAllBuy()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - CloseAllBuy: No open Buy orders to close");
         return true;
      }
      
      for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
            if(OrderType() == OP_BUY)
            {
               if(OrderClose(OrderTicket(), OrderLots(), Bid, 100))
               {
                  continue;
               }
               else
               {
                  Print("TradeAssist - CloseAllBuy: Unable to close an order, ticket: ", OrderTicket(), " ", GetLastError());
                  ResetLastError();
                  return false;
               }
            }
         }
         else
         {
            Print("TradeAssist - CloseAllBuy: Unable to select an order: ",i, " ", GetLastError());
            ResetLastError();
            return false;
         }
      }
      return true;
   }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Close All Sell                                                   |
//+------------------------------------------------------------------+
/*
   Close all Sell orders.
   Returns true if successful, false otherwise.
*/
   bool CloseAllSell()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - CloseAllSell: No open Sell orders to close");
         return true;
      }
      
      for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
            if(OrderType() == OP_SELL)
            {
               if(OrderClose(OrderTicket(), OrderLots(), Ask, 100))
               {
                  continue;
               }
               else
               {
                  Print("TradeAssist - CloseAllSell: Unable to close an order, ticket: ", OrderTicket(), " ", GetLastError());
                  ResetLastError();
                  return false;
               }
            }
         }
         else
         {
            Print("TradeAssist - CloseAllSell: Unable to select an order: ",i, " ", GetLastError());
            ResetLastError();
            return false;
         }
      }
      return true;
   }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Close All Buy Limit                                              |
//+------------------------------------------------------------------+
/*
   Close all BuyLimit orders.
   Returns true if successful, false otherwise.
*/
   bool CloseAllBuyLimit()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - CloseAllBuyLimit: No BuyLimit orders to close");
         return true;
      }
      for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
            if(OrderType() == OP_BUYLIMIT)
            {
               if(OrderDelete(OrderTicket()))
               {
                  continue;
               }
               else
               {
                  Print("TradeAssist - CloseAllBuyLimit: Unable to close an order, ticket: ", OrderTicket(), " ", GetLastError());
                  ResetLastError();
                  return false;
               }
            }
         }
         else
         {
            Print("TradeAssist - CloseAllBuyLimit: Unable to select an order: ",i, " ", GetLastError());
            ResetLastError();
            return false;
         }
      }
      return true;
   }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Close All Sell Limit                                             |
//+------------------------------------------------------------------+
/*
   Close all SellLimit orders.
   Returns true if successful, false otherwise.
*/
   bool CloseAllSellLimit()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - CloseAllSellLimit: No SellLimit orders to close");
         return true;
      }
      for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
            if(OrderType() == OP_SELLLIMIT)
            {
               if(OrderDelete(OrderTicket()))
               {
                  continue;
               }
               else
               {
                  Print("TradeAssist - CloseAllSellLimit: Unable to close an order, ticket: ", OrderTicket(), " ", GetLastError());
                  ResetLastError();
                  return false;
               }
            }
         }
         else
         {
            Print("TradeAssist - CloseAllSellLimit: Unable to select an order: ",i, " ", GetLastError());
            ResetLastError();
            return false;
         }
      }
      return true;
   }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Close All Buy Stop                                               |
//+------------------------------------------------------------------+
/*
   Close all BuyStop orders.
   Returns true if successful, false otherwise.
*/
   bool CloseAllBuyStop()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - CloseAllBuyStop: No BuyStop orders to close");
         return true;
      }
      for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
            if(OrderType() == OP_BUYSTOP)
            {
               if(OrderDelete(OrderTicket()))
               {
                  continue;
               }
               else
               {
                  Print("TradeAssist - CloseAllBuyStop: Unable to close an order, ticket: ", OrderTicket(), " ", GetLastError());
                  ResetLastError();
                  return false;
               }
            }
         }
         else
         {
            Print("TradeAssist - CloseAllBuyStop: Unable to select an order: ",i, " ", GetLastError());
            ResetLastError();
            return false;
         }
      }
      return true;
   }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Close All Sell Stop                                              |
//+------------------------------------------------------------------+
/*
   Close all SellStop orders.
   Returns true if successful, false otherwise.
*/
   bool CloseAllSellStop()
   {
      if(OrdersTotal() == 0)
      {
         Print("TradeAssist - CloseAllSellStop: No SellStop orders to close");
         return true;
      }
      for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {
            if(OrderType() == OP_SELLSTOP)
            {
               if(OrderDelete(OrderTicket()))
               {
                  continue;
               }
               else
               {
                  Print("TradeAssist - CloseAllSellStop: Unable to close an order, ticket: ", OrderTicket(), " ", GetLastError());
                  ResetLastError();
                  return false;
               }
            }
         }
         else
         {
            Print("TradeAssist - CloseAllSellStop: Unable to select an order: ",i, " ", GetLastError());
            ResetLastError();
            return false;
         }
      }
      return true;
   }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Get Orders Number                                             |
//+------------------------------------------------------------------+
/*
   OP_TYPE: Type of the orders to count. Use 6 to count all.
   SYMBOL: count for a symbol.
   Returns a number of open orders of a type specified in the argument.
   Returns a positive integer, 0 if no orders, -1 if failed.
*/
   int GetOrdersNumber(int OP_TYPE, string SYMBOL)
   {
      int orderCount = 0;
      for(int i=0; i<OrdersTotal(); i++)
      {
         if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         {   
            if((OrderType() == OP_TYPE || OP_TYPE == 6) && OrderSymbol() == SYMBOL)
            {
               orderCount++;
            }
         }
         else
         {
            Print("TradeAssist - GetOrdersNumber: Unable to select an order: ",i, " ", GetLastError());
            ResetLastError();
            return -1;
         }      
      }
      return orderCount;
   }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Get Last Trade Result                                            |
//+------------------------------------------------------------------+
/*
   SYMBOL: symbol of a pair to check last closed trade result.
   OP_TYPE: direction of a trade, accepts OP_BUY, OP_SELL or 6 for both.
   Returns the result of the last closed trade or NULL, if any errors or no historic orders. 
   The history list size depends on the current settings of the "Account history" tab of the terminal.
*/
double GetLastTradeResult(string SYMBOL, int OP_TYPE)
{
   double result = 0;
   datetime closeTime = 0;
   if(OrdersHistoryTotal() == 0)
   {
      Print("TradeAssist - GetLastTradeResult: No orders in history");
      return NULL;
   }
   if(OP_TYPE != OP_BUY && OP_TYPE != OP_SELL && OP_TYPE != 6)
   {
      Print("TradeAssist - GetLastTradeResult: incorrect direction has been selected, check OP_TYPE argument");
      return NULL;
   }
   
   for(int i=0; i<OrdersHistoryTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
      {
         if((OrderSymbol() == SYMBOL && OrderCloseTime() > closeTime) && (OrderType() == OP_TYPE || OP_TYPE == 6))
         {
            closeTime = OrderCloseTime();
            result = OrderProfit();
         }
      }
      else
      {
         Print("TradeAssist - GetOrdersNumber: Unable to select a historical order: ",i, " ", GetLastError());
         ResetLastError();
         return NULL;
      }
   }
   return result;
}
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Is New Bar                                                    |
//+------------------------------------------------------------------+
/*
   Returns true if a new bar has appeared since last checked. False otherwise
*/

//+------------------------------------------------------------------+

bool isNewBar()
{
   datetime thisBarOpenTime = Time[0];
   if(thisBarOpenTime != lastBarOpenTime)
   {
      lastBarOpenTime = thisBarOpenTime;
      return (true);
   }
   else
   return (false);
}


//+------------------------------------------------------------------+
//| Get Worst Trade Profit                                           |
//+------------------------------------------------------------------+
/*
   OP_TYPE: type of orders to check. Accepts OP_BUY, OP_SELL and 6 for both.
   SYMBOL: symbol to run the check against.
   Returns the worst trade profit, 0 if no trades for the symbol, -1 if error occurs.
*/
double GetWorstTradeProfit(int OP_TYPE, string SYMBOL)
{
   double result = 0;
   if(OP_TYPE != OP_BUY || OP_TYPE != OP_SELL || OP_TYPE != 6)
   {
      Print("TradeAssist - GetWorstTradeProfit: Unsupported order type: ", OP_TYPE);
      return -1;
   }
   int ordersNumber = GetOrdersNumber(OP_TYPE, SYMBOL);
   if(ordersNumber == 0)
   {
      return result;
   }
   
   for(int i=0; i<OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      {
         if(OrderSymbol() == SYMBOL && (OrderType() == OP_TYPE || OrderType() == 6))
         {
            double profit = OrderProfit();
            if(profit < result)
               result = profit;
         }
         else continue;
      }
      else
      {
         Print("TradeAssist - GetWorstTradeProfit: Unable to select an order: ",i, ", Error: ", GetLastError());
         ResetLastError();
         return -1;
      }
   }
   return result;
}

//+------------------------------------------------------------------+