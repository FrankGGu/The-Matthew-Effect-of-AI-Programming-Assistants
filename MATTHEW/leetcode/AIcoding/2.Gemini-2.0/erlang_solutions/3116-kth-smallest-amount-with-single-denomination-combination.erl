-module(kth_smallest_amount).
-export([kth_smallest/2]).

kth_smallest(K, Denominations) ->
    lists:nth(K, lists:sort(flat_map(Denominations))).

flat_map(Denominations) ->
    flat_map_helper(Denominations, []).

flat_map_helper([], Acc) ->
    Acc;
flat_map_helper([H|T], Acc) ->
    flat_map_helper(T, flat_map_single(H, Acc)).

flat_map_single(Denomination, Acc) ->
    [Denomination * N || N <- lists:seq(1, 1000)] ++ Acc.