-module(k_divisible_elements_subarrays).
-export([subarrays_with_k_divisible_elements/2]).

subarrays_with_k_divisible_elements(Nums, K) ->
    Count = 0,
    Length = length(Nums),
    subarrays_with_k_divisible_elements(Nums, K, 0, Length, Count).

subarrays_with_k_divisible_elements(_, _, Start, Length, Count) when Start >= Length ->
    Count;
subarrays_with_k_divisible_elements(Nums, K, Start, Length, Count) ->
    Subarray = lists:sublist(Nums, Start + 1, Length - Start),
    NewCount = count_k_divisible(Subarray, K, 0),
    subarrays_with_k_divisible_elements(Nums, K, Start + 1, Length, Count + NewCount).

count_k_divisible([], _, Acc) ->
    Acc;
count_k_divisible([H | T], K, Acc) ->
    case H rem K of
        0 -> count_k_divisible(T, K, Acc + 1);
        _ -> count_k_divisible(T, K, Acc)
    end.