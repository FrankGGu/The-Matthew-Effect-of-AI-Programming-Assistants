-module(solution).
-export([array_rank_transform/1]).

array_rank_transform(Array) ->
    Sorted = lists:sort(Array),
    UniqueSorted = lists:usort(Sorted),
    ranks = lists:map(fun(X) -> lists:position(X, UniqueSorted) + 1 end, Array),
    ranks.