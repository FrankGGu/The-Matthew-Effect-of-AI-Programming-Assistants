-module(min_operations).
-export([min_operations/2]).

min_operations(K, Arr) ->
    Sorted = lists:sort(Arr),
    N = length(Sorted),
    Mid = N div 2,
    Current = lists:nth(Mid + 1, Sorted),
    if
        Current == K -> 0;
        Current < K -> K - Current;
        true -> Current - K
    end.