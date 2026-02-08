-module(solution).
-export([search/2]).

search(Nums, Target) ->
    search_helper(Nums, Target, 0, length(Nums) - 1).

search_helper(_Nums, _Target, Low, High) when Low > High ->
    -1;
search_helper(Nums, Target, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = lists:nth(Mid + 1, Nums),
    if
        Element == Target ->
            Mid;
        Element < Target ->
            search_helper(Nums, Target, Mid + 1, High);
        Element > Target ->
            search_helper(Nums, Target, Low, Mid - 1)
    end.