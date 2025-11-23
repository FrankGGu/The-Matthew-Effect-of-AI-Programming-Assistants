-module(solution).
-export([maximumCandies/2]).

maximumCandies(Candies, K) ->
    Max = lists:max(Candies),
    MinCandies = 0,
    MaxCandies = Max,
    fun(N) -> lists:sum(lists:map(fun(X) -> X div N end, Candies)) >= K end,
    binary_search(MinCandies, MaxCandies, fun(N) -> fun(N) end).

binary_search(Low, High, F) when Low < High ->
    Mid = (Low + High + 1) div 2,
    if F(Mid) ->
        binary_search(Mid, High, F);
    true ->
        binary_search(Low, Mid - 1, F)
    end;
binary_search(Low, High, _) ->
    Low.