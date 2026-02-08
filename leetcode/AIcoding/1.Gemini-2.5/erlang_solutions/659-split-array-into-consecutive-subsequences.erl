-module(solution).
-export([is_possible/1]).

-spec is_possible(Nums :: [integer()]) -> boolean().
is_possible(Nums) ->
    CountMap0 = lists:foldl(fun(N, Acc) ->
                                    maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
                            end, #{}, Nums),

    EndMap0 = #{},

    try
        lists:foldl(fun(N, {CountMap, EndMap}) ->
                            case maps:get(N, CountMap, 0) of
                                0 ->
                                    {CountMap, EndMap};
                                _ ->
                                    case maps:get(N - 1, EndMap, 0) of
                                        EndNMinus1Count when EndNMinus1Count > 0 ->
                                            NewCountMap = maps:update_with(N, fun(V) -> V - 1 end, CountMap),
                                            NewEndMap = maps:update_with(N - 1, fun(V) -> V - 1 end, EndMap),
                                            NewEndMap2 = maps:update_with(N, fun(V) -> V + 1 end, 1, NewEndMap),
                                            {NewCountMap, NewEndMap2};
                                        _ ->
                                            CountNPlus1 = maps:get(N + 1, CountMap, 0),
                                            CountNPlus2 = maps:get(N + 2, CountMap, 0),
                                            if CountNPlus1 > 0 andalso CountNPlus2 > 0 ->
                                                   NewCountMap = maps:update_with(N, fun(V) -> V - 1 end, CountMap),
                                                   NewCountMap2 = maps:update_with(N + 1, fun(V) -> V - 1 end, NewCountMap),
                                                   NewCountMap3 = maps:update_with(N + 2, fun(V) -> V - 1 end, NewCountMap2),
                                                   NewEndMap = maps:update_with(N + 2, fun(V) -> V + 1 end, 1, EndMap),
                                                   {NewCountMap3, NewEndMap};
                                                true ->
                                                   throw(false)
                                            end
                                    end
                            end
                    end, {CountMap0, EndMap0}, Nums)
    of
        {_, _} -> true
    catch
        false -> false
    end.