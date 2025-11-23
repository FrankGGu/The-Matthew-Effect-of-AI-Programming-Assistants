-module(minimum_coins_fruits).
-export([min_cost]).

min_cost(Prices) ->
    min_cost(Prices, 0, []).

min_cost([], Acc, _) ->
    Acc;
min_cost([Price | Rest], Acc, []) ->
    min_cost(Rest, Acc + Price, [Price]);
min_cost([Price | Rest], Acc, [Prev]) ->
    case Price < Prev of
        true ->
            min_cost(Rest, Acc + Price, [Price]);
        false ->
            min_cost(Rest, Acc, [])
    end.