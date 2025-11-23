-module(maximum_xor_score_subarray_queries).
-export([maximum_xor_score_subarray_queries/2]).

maximum_xor_score_subarray_queries(Nums, Queries) ->
    maximum_xor_score_subarray_queries(Nums, Queries, []).

maximum_xor_score_subarray_queries([], _, Acc) ->
    lists:reverse(Acc);
maximum_xor_score_subarray_queries(Nums, [Query|RestQueries], Acc) ->
    {L, R} = Query,
    Subarray = lists:sublist(Nums, L + 1, R - L + 1),
    MaxXorScore = max_xor_score(Subarray),
    maximum_xor_score_subarray_queries(Nums, RestQueries, [MaxXorScore|Acc]).

max_xor_score(Nums) ->
    max_xor_score(Nums, 0).

max_xor_score([], MaxSoFar) ->
    MaxSoFar;
max_xor_score(Nums, MaxSoFar) ->
    max_xor_score(Nums, MaxSoFar, 0).

max_xor_score(Nums, MaxSoFar, StartIndex) ->
    Len = length(Nums),
    if StartIndex >= Len then
        MaxSoFar
    else
        MaxSoFar1 = max_xor_score_from(Nums, StartIndex, 0, MaxSoFar),
        max_xor_score(Nums, MaxSoFar1, StartIndex + 1)
    end.

max_xor_score_from(Nums, StartIndex, CurrentXor, MaxSoFar) ->
    Len = length(Nums),
    if StartIndex >= Len then
        MaxSoFar
    else
        NewXor = CurrentXor bxor lists:nth(StartIndex + 1, Nums),
        NewMaxSoFar = max(MaxSoFar, NewXor),
        max_xor_score_from(Nums, StartIndex + 1, NewXor, NewMaxSoFar)
    end.

max(A, B) ->
    if A > B then
        A
    else
        B
    end.