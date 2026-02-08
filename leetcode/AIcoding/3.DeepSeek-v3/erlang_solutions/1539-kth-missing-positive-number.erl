-spec find_kth_positive(Arr :: [integer()], K :: integer()) -> integer().
find_kth_positive(Arr, K) ->
    lists:nth(K, lists:subtract(lists:seq(1, lists:max(Arr) + K), Arr)).