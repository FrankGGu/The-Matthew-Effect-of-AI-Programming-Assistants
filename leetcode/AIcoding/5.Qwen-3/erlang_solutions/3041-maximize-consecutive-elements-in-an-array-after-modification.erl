-module(maximize_consecutive_elements_in_an_array_after_modification).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 0, 0, 0).

solve([], _, _, Max, _) ->
    Max;
solve([H | T], Count, Prev, Max, _) when H == Prev + 1 ->
    solve(T, Count + 1, H, max(Max, Count + 1), 0);
solve([H | T], Count, Prev, Max, _) when H == Prev ->
    solve(T, Count, H, Max, 0);
solve([H | T], Count, Prev, Max, _) ->
    solve(T, 1, H, max(Max, Count), 0).