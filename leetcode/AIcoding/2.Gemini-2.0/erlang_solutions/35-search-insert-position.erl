-module(solution).
-export([search_insert/2]).

search_insert(Nums, Target) ->
    search_insert(Nums, Target, 0, length(Nums) - 1).

search_insert(Nums, Target, Low, High) when Low > High ->
    Low;
search_insert(Nums, Target, Low, High) ->
    Mid = (Low + High) div 2,
    case Nums !! Mid of
        Target ->
            Mid;
        Val when Val < Target ->
            search_insert(Nums, Target, Mid + 1, High);
        _ ->
            search_insert(Nums, Target, Low, Mid - 1)
    end.