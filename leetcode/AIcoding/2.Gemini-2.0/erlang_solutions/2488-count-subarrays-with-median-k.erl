-module(count_subarrays_with_median_k).
-export([num_subarrays_with_median_k/2]).

num_subarrays_with_median_k(Nums, K) ->
    num_subarrays_with_median_k(Nums, K, 0, 0, 0, 0, maps:new()).

num_subarrays_with_median_k([], _, Count, _, _, _, _) ->
    Count;
num_subarrays_with_median_k([Num | Rest], K, Count, Less, Greater, Equal, PrefixSumMap) ->
    case Num of
        N when N < K ->
            NewLess = Less + 1,
            NewGreater = Greater,
            NewEqual = Equal;
        N when N > K ->
            NewLess = Less,
            NewGreater = Greater + 1,
            NewEqual = Equal;
        _ ->
            NewLess = Less,
            NewGreater = Greater,
            NewEqual = Equal + 1
    end,
    NewPrefixSum = NewLess - NewGreater,
    NewCount = case NewEqual of
        0 ->
            case maps:is_key(NewPrefixSum, PrefixSumMap) of
                true ->
                    Count + maps:get(NewPrefixSum, PrefixSumMap) +
                        (case maps:is_key(NewPrefixSum - 1, PrefixSumMap) of
                             true -> maps:get(NewPrefixSum - 1, PrefixSumMap);
                             false -> 0
                         end);
                false ->
                    Count + (case maps:is_key(NewPrefixSum - 1, PrefixSumMap) of
                                 true -> maps:get(NewPrefixSum - 1, PrefixSumMap);
                                 false -> 0
                             end)
            end;
        _ ->
            case maps:is_key(NewPrefixSum, PrefixSumMap) of
                true ->
                    Count + maps:get(NewPrefixSum, PrefixSumMap) + 1 +
                        (case maps:is_key(NewPrefixSum - 1, PrefixSumMap) of
                             true -> maps:get(NewPrefixSum - 1, PrefixSumMap);
                             false -> 0
                         end);
                false ->
                    Count + 1 + (case maps:is_key(NewPrefixSum - 1, PrefixSumMap) of
                                     true -> maps:get(NewPrefixSum - 1, PrefixSumMap);
                                     false -> 0
                                 end)
            end
    end,

    NewMap = maps:update_with(NewPrefixSum,
                               fun(V) -> V + 1 end,
                               1,
                               PrefixSumMap),

    num_subarrays_with_median_k(Rest, K, NewCount, NewLess, NewGreater, NewEqual, NewMap).