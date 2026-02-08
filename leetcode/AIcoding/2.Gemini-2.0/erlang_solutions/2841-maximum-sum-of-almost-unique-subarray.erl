-module(max_sum_almost_unique_subarray).
-export([maximum_sum_subarray/2]).

maximum_sum_subarray(Nums, M) ->
    maximum_sum_subarray(Nums, M, 0, 0, 0, 0, maps:new()).

maximum_sum_subarray([], _M, _L, _R, MaxSum, _CurrentSum, _CountMap) ->
    MaxSum;
maximum_sum_subarray(Nums, M, L, R, MaxSum, CurrentSum, CountMap) ->
    case (R - L + 1) < M of
        true ->
            case Nums of
                [H | T] ->
                    NewCountMap = maps:update_with(H, fun(V) -> V + 1 end, 1, CountMap),
                    NewCurrentSum = CurrentSum + H,
                    maximum_sum_subarray(T, M, L, R + 1, MaxSum, NewCurrentSum, NewCountMap);
                [] ->
                    MaxSum
            end;
        false ->
            NumUnique = maps:size(maps:filter(fun(_K, V) -> V > 0 end, CountMap)),
            case NumUnique >= M of
                true ->
                    NewMaxSum = max(MaxSum, CurrentSum),
                    case lists:nth(L + 1, Nums) of
                        FirstVal ->
                            case maps:get(FirstVal, CountMap, 0) of
                                1 ->
                                    NewCountMap = maps:remove(FirstVal, CountMap);
                                _ ->
                                    NewCountMap = maps:update_with(FirstVal, fun(V) -> V - 1 end, 0, CountMap)
                            end,
                            NewCurrentSum = CurrentSum - FirstVal,
                            case tl(Nums) of
                                [H | T] ->
                                    NewCountMap2 = maps:update_with(H, fun(V) -> V + 1 end, 1, NewCountMap),
                                    NewCurrentSum2 = NewCurrentSum + H,
                                    maximum_sum_subarray(T, M, L + 1, R, NewMaxSum, NewCurrentSum2, NewCountMap2);
                                [] ->
                                    NewMaxSum
                            end
                    end;
                false ->
                    case lists:nth(L + 1, Nums) of
                        FirstVal ->
                            case maps:get(FirstVal, CountMap, 0) of
                                1 ->
                                    NewCountMap = maps:remove(FirstVal, CountMap);
                                _ ->
                                    NewCountMap = maps:update_with(FirstVal, fun(V) -> V - 1 end, 0, CountMap)
                            end,
                            NewCurrentSum = CurrentSum - FirstVal,
                            case tl(Nums) of
                                [H | T] ->
                                    NewCountMap2 = maps:update_with(H, fun(V) -> V + 1 end, 1, NewCountMap),
                                    NewCurrentSum2 = NewCurrentSum + H,
                                    maximum_sum_subarray(T, M, L + 1, R, MaxSum, NewCurrentSum2, NewCountMap2);
                                [] ->
                                    MaxSum
                            end
                    end

            end
    end.