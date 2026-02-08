-module(best_time_to_buy_sell_stock_with_cooldown).
-export([maxProfit/1]).

maxProfit(Prices) ->
  maxProfit_helper(Prices, 0, 0, 0, length(Prices)).

maxProfit_helper(_Prices, _Index, Buy, Sell, _Len) when Buy >= Sell ->
  0;
maxProfit_helper(_Prices, _Index, _Buy, _Sell, Len) when _Sell >= Len ->
  0;
maxProfit_helper(Prices, Index, Buy, Sell, Len) ->
  Price = lists:nth(Index + 1, Prices),

  BuyProfit = case Buy of
                0 -> maxProfit_helper(Prices, Index + 1, Index + 1, Sell, Len);
                _ -> -10000000000  % 负无穷
              end,

  SellProfit = case Sell of
                 0 -> -10000000000; % 负无穷
                 _ -> Price - lists:nth(Sell, Prices) + maxProfit_helper(Prices, Index + 1, 0, Index + 2, Len)
               end,

  NoActionProfit = maxProfit_helper(Prices, Index + 1, Buy, Sell, Len),

  max([BuyProfit, SellProfit, NoActionProfit]).

maxProfit(Prices) ->
    case Prices of
        [] -> 0;
        _ ->
            N = length(Prices),
            {Buy, Sell, Rest} = lists:foldl(fun(Price, {BuyAcc, SellAcc, RestAcc}) ->
                                                 {
                                                     case BuyAcc of
                                                         [] -> [0];
                                                         [H|_] -> [max(H, SellAcc ++ [0]) ++ [0]]
                                                     end,
                                                     case SellAcc of
                                                         [] -> [-Price];
                                                         [H|_] -> [max(H, RestAcc ++ [-Price]) ++ [-Price]]
                                                     end,
                                                     case RestAcc of
                                                         [] -> [0];
                                                         [H|_] -> [max(H, BuyAcc ++ [H + Price]) ++ [0]]
                                                     end
                                                 }
                                             end, {[], [], []}, Prices),
            lists:max([lists:last(Buy), lists:last(Sell), lists:last(Rest)])
    end.