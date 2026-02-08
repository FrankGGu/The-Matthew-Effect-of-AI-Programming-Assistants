-module(solution).
-export([getMaximumConsecutive/1]).

getMaximumConsecutive(Coins) ->
    SortedCoins = lists:sort(Coins),
    solve(SortedCoins, 0).

solve([], ReachableMax) ->
    ReachableMax + 1;
solve([H|T], ReachableMax) ->
    if
        H > ReachableMax + 1 ->
            ReachableMax + 1;
        true ->
            solve(T, ReachableMax + H)
    end.