-module(solution).
-export([numIdenticalPairs/1]).

numIdenticalPairs(List) ->
    Count = lists:foldl(fun(X, Acc) -> Acc + lists:count(X, List) - 1 end, 0, lists:uniq(List)),
    Count div 2.