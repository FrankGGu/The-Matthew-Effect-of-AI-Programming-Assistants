-module(solution).
-export([intersect/2]).

intersect(Nums1, Nums2) ->
    {ShorterList, LongerList} = 
        case length(Nums1) =< length(Nums2) of
            true -> {Nums1, Nums2};
            false -> {Nums2, Nums1}
        end,

    FreqMap = lists:foldl(fun(X, Map) ->
                               maps:update_with(X, fun(V) -> V + 1 end, 1, Map)
                           end, maps:new(), ShorterList),

    {_FinalMap, ResultAcc} = lists:foldl(fun(X, {Map, Acc}) ->
                                            case maps:find(X, Map) of
                                                {ok, Count} when Count > 0 ->
                                                    NewMap = maps:update(X, Count - 1, Map),
                                                    {NewMap, [X | Acc]};
                                                _ ->
                                                    {Map, Acc}
                                            end
                                        end, {FreqMap, []}, LongerList),

    lists:reverse(ResultAcc).