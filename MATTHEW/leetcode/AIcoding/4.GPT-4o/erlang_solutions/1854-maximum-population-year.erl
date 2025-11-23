-module(solution).
-export([maximum_population/1]).

maximum_population(P) ->
    YearCounts = lists:foldl(fun({B, D}, Acc) ->
        lists:foldl(fun(Y, Acc2) -> 
            maps:update_with(Y, fun(Count) -> Count + 1 end, 1, Acc2)
        end, Acc, lists:seq(B, D - 1))
    end, #{}, P),
    YearCountList = maps:to_list(YearCounts),
    lists:max(YearCountList).