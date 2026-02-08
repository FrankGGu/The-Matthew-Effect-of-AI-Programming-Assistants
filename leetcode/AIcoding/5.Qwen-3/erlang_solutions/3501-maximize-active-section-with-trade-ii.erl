-module(maximize_active_section_with_trade_ii).
-export([maxProfit/1]).

maxProfit(Prices) ->
    maxProfit(Prices, 0, 0, 0, 0).

maxProfit([], _, _, _, Profit) ->
    Profit;
maxProfit([Price | Rest], Buy1, Sell1, Buy2, Sell2) ->
    NewBuy1 = erlang:max(Buy1, -Price),
    NewSell1 = erlang:max(Sell1, Buy1 + Price),
    NewBuy2 = erlang:max(Buy2, Sell1 - Price),
    NewSell2 = erlang:max(Sell2, Buy2 + Price),
    maxProfit(Rest, NewBuy1, NewSell1, NewBuy2, NewSell2).