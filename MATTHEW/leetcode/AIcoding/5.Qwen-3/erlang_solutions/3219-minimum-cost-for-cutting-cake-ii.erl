-module(minimum_cost_for_cutting_cake_ii).
-export([cost/2]).

cost(Cuts, Prices) ->
    Cuts1 = lists:sort(Cuts),
    PriceMap = maps:from_list(Prices),
    cost(Cuts1, PriceMap, 0, 1).

cost([], _PriceMap, _Cost, _Width) ->
    0;
cost([Cut | Rest], PriceMap, Acc, Width) ->
    Price = maps:get(Width, PriceMap, 0),
    NewAcc = Acc + Price,
    cost(Rest, PriceMap, NewAcc, Cut).