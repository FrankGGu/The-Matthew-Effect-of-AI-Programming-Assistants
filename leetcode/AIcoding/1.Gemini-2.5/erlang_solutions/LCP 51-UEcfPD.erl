-module(solution).
-export([max_deliciousness/4]).

max_deliciousness(Materials, Cookbooks, Attribute, K) ->
    N = length(Cookbooks),
    M = length(Materials),

    InitialMaterialTuple = list_to_tuple(lists:duplicate(M, 0)),

    DP_array_init = array:new([{fixed, true}, {size, K + 1}, {default, #{}}]),
    DP_array_with_initial_state = array:set(0, #{InitialMaterialTuple => 0}, DP_array_init),

    FinalDPArray = lists:foldl(
        fun(J, AccDPArray) ->
            CurrentDPMap = array:get(J, AccDPArray),
            NextDPMap = #{},

            UpdatedNextDPMap = lists:foldl(
                fun({UsedMaterialsTuple, CurrentDeliciousness}, InnerAccNextDPMap) ->
                    lists:foldl(
                        fun(DishIdx, InnerInnerAccNextDPMap) ->
                            DishCookbook = lists:nth(DishIdx + 1, Cookbooks),
                            DishAttribute = lists:nth(DishIdx + 1, Attribute),

                            NewUsedMaterialsList = lists:zipwith(
                                fun(Used, Required) -> Used + Required end,
                                tuple_to_list(UsedMaterialsTuple),
                                DishCookbook
                            ),

                            ExceedsMaterials = lists:any(
                                fun({NewUsed, Initial}) -> NewUsed > Initial end,
                                lists:zip(NewUsedMaterialsList, Materials)
                            ),

                            if
                                ExceedsMaterials ->
                                    InnerInnerAccNextDPMap;
                                true ->
                                    NewUsedMaterialsTuple = list_to_tuple(NewUsedMaterialsList),
                                    NewDeliciousness = CurrentDeliciousness + DishAttribute,

                                    case maps:find(NewUsedMaterialsTuple, InnerInnerAccNextDPMap) of
                                        {ok, ExistingDeliciousness} ->
                                            maps:put(NewUsedMaterialsTuple, max(ExistingDeliciousness, NewDeliciousness), InnerInnerAccNextDPMap);
                                        error ->
                                            maps:put(NewUsedMaterialsTuple, NewDeliciousness, InnerInnerAccNextDPMap)
                                    end
                            end
                        end,
                        InnerAccNextDPMap,
                        lists:seq(0, N - 1)
                    )
                end,
                NextDPMap,
                maps:to_list(CurrentDPMap)
            ),
            array:set(J + 1, UpdatedNextDPMap, AccDPArray)
        end,
        DP_array_with_initial_state,
        lists:seq(0, K - 1)
    ),

    FinalDPMap = array:get(K, FinalDPArray),

    case maps:is_empty(FinalDPMap) of
        true ->
            -1;
        false ->
            lists:max(maps:values(FinalDPMap))
    end.