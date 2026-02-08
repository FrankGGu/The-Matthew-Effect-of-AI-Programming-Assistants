-module(minimum_operations_to_exceed_threshold_value_ii).
-export([solve/2]).

solve(Nums, K) ->
    solve(lists:sort(Nums), K, 0).

solve([], _, Acc) ->
    Acc;
solve([H | T], K, Acc) when H >= K ->
    Acc;
solve([H1, H2 | T], K, Acc) ->
    New_val = min(K, H1 * 2 + H2),
    solve(lists:sort([New_val | T]), K, Acc + 1);
solve([H], K, Acc) ->
    Acc + 1.