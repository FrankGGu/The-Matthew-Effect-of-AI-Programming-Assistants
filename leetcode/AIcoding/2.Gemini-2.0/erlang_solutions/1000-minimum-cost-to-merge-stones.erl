-module(merge_stones).
-export([min_cost/3]).

min_cost(Stones, K, M) ->
    Len = length(Stones),
    if (Len - 1) rem (K - 1) /= 0 orelse Len < K then
        -1
    else
        Sums = lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], lists:reverse(Stones)),
        DP = array:new([{1, Len, 1}], {infinity, []}),
        lists:foreach(fun(I) ->
                         array:set({I, I, 1}, {0, []}, DP)
                 end, lists:seq(1, Len)),

        min_cost_helper(1, Len, 1, Stones, K, Sums, DP)
    end.

min_cost_helper(L, R, M, Stones, K, Sums, DP) ->
    case array:get({L, R, M}, DP) of
        {infinity, _} ->
            case M of
                1 ->
                    if L == R then
                        array:set({L, R, M}, {0, []}, DP),
                        0
                    else
                        BestCost = lists:foldl(
                            fun(I, Acc) ->
                                 Cost1 = min_cost_helper(L, I, 1, Stones, K, Sums, DP),
                                 Cost2 = min_cost_helper(I + 1, R, 1, Stones, K, Sums, DP),
                                 min(Acc, Cost1 + Cost2)
                            end, infinity, lists:seq(L, R - 1)
                        ),
                        array:set({L, R, M}, {BestCost, []}, DP),
                        BestCost
                    end;
                _ ->
                    BestCost = min_cost_helper(L, R, 1, Stones, K, Sums, DP),
                    if BestCost == -1 then
                        array:set({L, R, M}, {infinity, []}, DP),
                        infinity
                    else
                        Cost = min_cost_helper(L, R, M - 1, Stones, K, Sums, DP),
                        array:set({L, R, M}, {Cost, []}, DP),
                        Cost
                    end
            end;
        {Cost, _} ->
            Cost
    end.

infinity ->
    1000000000.