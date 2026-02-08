-module(minimize_max_pair_sum).
-export([minimize_max_pair_sum/1]).

minimize_max_pair_sum(Nums) ->
    Sorted = lists:sort(Nums),
    do_minimize(Sorted, 0, 0).

do_minimize([], _, Max) ->
    Max;
do_minimize([H | T], Index, Max) ->
    Pair = lists:nth(Index + 1, T) + H,
    NewMax = max(Max, Pair),
    do_minimize(T, Index + 1, NewMax).