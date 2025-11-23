-spec num_of_subarrays(Arr :: [integer()], K :: integer(), Threshold :: integer()) -> integer().
num_of_subarrays(Arr, K, Threshold) ->
    Sum = lists:sum(lists:sublist(Arr, K)),
    Count = if Sum >= K * Threshold -> 1; true -> 0 end,
    num_of_subarrays(Arr, K, Threshold, 1, K + 1, Sum, Count).

num_of_subarrays(Arr, K, Threshold, I, J, Sum, Count) when J =< length(Arr) ->
    NewSum = Sum - lists:nth(I, Arr) + lists:nth(J, Arr),
    NewCount = if NewSum >= K * Threshold -> Count + 1; true -> Count end,
    num_of_subarrays(Arr, K, Threshold, I + 1, J + 1, NewSum, NewCount);
num_of_subarrays(_, _, _, _, _, _, Count) ->
    Count.