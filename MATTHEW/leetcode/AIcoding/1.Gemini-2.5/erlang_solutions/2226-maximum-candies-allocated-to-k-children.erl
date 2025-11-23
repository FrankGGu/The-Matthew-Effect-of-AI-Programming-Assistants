-module(solution).
-export([maximumCandies/2]).

maximumCandies(Candies, K) ->
    Low = 0,
    High = lists:max(Candies), % Max possible candies per child
    binary_search(Low, High, Candies, K, 0).

binary_search(Low, High, _Candies, _K, CurrentAns) when Low > High ->
    CurrentAns;
binary_search(Low, High, Candies, K, CurrentAns) ->
    Mid = Low + (High - Low) div 2,
    if
        can_allocate(Mid, Candies, K) ->
            binary_search(Mid + 1, High, Candies, K, Mid);
        true ->
            binary_search(Low, Mid - 1, Candies, K, CurrentAns)
    end.

can_allocate(X, Candies, K) when X == 0 ->
    true;
can_allocate(X, Candies, K) ->
    TotalChildren = lists:foldl(fun(C, Acc) -> Acc + (C div X) end, 0, Candies),
    TotalChildren >= K.