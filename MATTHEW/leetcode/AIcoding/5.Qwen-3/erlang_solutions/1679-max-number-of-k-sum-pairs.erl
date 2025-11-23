-module(solution).
-export([max_k_sum_pairs/2]).

max_k_sum_pairs(Nums, K) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    MaxPairs = 0,
    lists:foldl(fun(N, Acc) ->
        case maps:is_key(N, Count) of
            true ->
                Pair = K - N,
                if
                    Pair == N ->
                        CountN = maps:get(N, Count),
                        Pairs = CountN div 2,
                        maps:put(N, 0, Count),
                        Acc + Pairs;
                    true ->
                        if
                            maps:is_key(Pair, Count) ->
                                CountN = maps:get(N, Count),
                                CountP = maps:get(Pair, Count),
                                Min = min(CountN, CountP),
                                maps:put(N, CountN - Min, maps:put(Pair, CountP - Min, Count)),
                                Acc + Min;
                            true ->
                                Acc
                        end
                end;
            false ->
                Acc
        end
    end, MaxPairs, maps:keys(Count)).