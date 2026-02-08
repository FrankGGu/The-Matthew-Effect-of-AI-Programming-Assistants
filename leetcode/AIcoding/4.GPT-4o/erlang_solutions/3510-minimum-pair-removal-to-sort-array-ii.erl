-module(solution).
-export([min_pair_removal/1]).

min_pair_removal(A) ->
    Count = lists:foldl(fun(X, Acc) -> Acc + 1 end, 0, A),
    UniqueCount = maps:size(lists:usort(A)),
    Count - UniqueCount.