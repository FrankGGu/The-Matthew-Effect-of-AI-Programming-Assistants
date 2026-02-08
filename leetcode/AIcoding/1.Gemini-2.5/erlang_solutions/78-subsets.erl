-module(solution).
-export([subsets/1]).

subsets([]) ->
    [[]];
subsets([H|T]) ->
    SubsetsOfT = subsets(T),
    SubsetsWithH = [[H|S] || S <- SubsetsOfT],
    SubsetsOfT ++ SubsetsWithH.