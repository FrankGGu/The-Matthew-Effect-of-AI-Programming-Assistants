-module(solution).
-export([beautiful_subsets/2]).

beautiful_subsets(Nums, K) ->
    Count = count_beautiful_subsets(Nums, K, 0, #{}),
    Count - 1.

count_beautiful_subsets([], _K, _Mask, _Map) ->
    1;
count_beautiful_subsets([Num | Rest], K, Mask, Map) ->
    case maps:get(Num, Map, 0) of
        0 ->
            NewMap = maps:put(Num, 1, Map),
            Take = count_beautiful_subsets(Rest, K, Mask bor (1 bsl Num), NewMap),
            Skip = count_beautiful_subsets(Rest, K, Mask, Map),
            Take + Skip;
        _ ->
            count_beautiful_subsets(Rest, K, Mask, Map)
    end.