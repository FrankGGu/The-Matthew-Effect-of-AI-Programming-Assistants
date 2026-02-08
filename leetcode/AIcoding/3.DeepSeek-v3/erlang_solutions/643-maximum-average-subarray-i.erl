-spec find_max_average(Nums :: [integer()], K :: integer()) -> float().
find_max_average(Nums, K) ->
    Sum = lists:sum(lists:sublist(Nums, K)),
    MaxSum = find_max_sum(Nums, K, length(Nums), Sum, Sum),
    MaxSum / K.

find_max_sum(_, _, Length, _, MaxSum) when Length =< 0 -> MaxSum;
find_max_sum([_ | T], K, Length, CurrentSum, MaxSum) ->
    NewSum = CurrentSum - hd(T) + lists:nth(K + (length(T) - Length + 1), T),
    NewMaxSum = max(NewSum, MaxSum),
    find_max_sum(T, K, Length - 1, NewSum, NewMaxSum).