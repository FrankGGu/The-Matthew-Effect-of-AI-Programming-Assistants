-module(solution).
-export([find_error_nums/1]).

find_error_nums(Nums) ->
    N = length(Nums),
    {Duplicate, DistinctSet} = find_duplicate_and_distinct_set(Nums, gb_sets:new(), 0),
    Missing = find_missing(1, N, DistinctSet),
    {Duplicate, Missing}.

find_duplicate_and_distinct_set([], AccSet, AccDuplicate) ->
    {AccDuplicate, AccSet};
find_duplicate_and_distinct_set([H|T], AccSet, AccDuplicate) ->
    case gb_sets:is_member(H, AccSet) of
        true ->
            find_duplicate_and_distinct_set(T, AccSet, H);
        false ->
            find_duplicate_and_distinct_set(T, gb_sets:add(H, AccSet), AccDuplicate)
    end.

find_missing(Current, Max, DistinctSet) when Current =< Max ->
    case gb_sets:is_member(Current, DistinctSet) of
        true ->
            find_missing(Current + 1, Max, DistinctSet);
        false ->
            Current
    end;
find_missing(_Current, _Max, _DistinctSet) ->
    0.