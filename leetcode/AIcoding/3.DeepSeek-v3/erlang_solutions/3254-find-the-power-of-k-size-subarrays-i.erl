-spec power_of_subarrays(Nums :: [integer()], K :: integer()) -> [integer()].
power_of_subarrays(Nums, K) ->
    Len = length(Nums),
    if
        K > Len -> [];
        true ->
            power_of_subarrays(Nums, K, Len, 1, [])
    end.

power_of_subarrays(Nums, K, Len, Start, Acc) when Start + K - 1 =< Len ->
    Subarray = lists:sublist(Nums, Start, K),
    Min = lists:min(Subarray),
    Sum = lists:sum(Subarray),
    Power = Min * Sum,
    power_of_subarrays(Nums, K, Len, Start + 1, [Power | Acc]);
power_of_subarrays(_, _, _, _, Acc) ->
    lists:reverse(Acc).