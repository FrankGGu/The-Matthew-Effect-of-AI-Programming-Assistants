-module(solution).
-export([search_insert/2]).

search_insert(Nums, Target) ->
    Len = length(Nums),
    search_insert_bs(Nums, Target, 0, Len - 1).

search_insert_bs(_Nums, _Target, Low, High) when Low > High ->
    Low;
search_insert_bs(Nums, Target, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Val = lists:nth(Mid + 1, Nums),
    if
        Val == Target -> Mid;
        Val < Target -> search_insert_bs(Nums, Target, Mid + 1, High);
        Val > Target -> search_insert_bs(Nums, Target, Low, Mid - 1)
    end.