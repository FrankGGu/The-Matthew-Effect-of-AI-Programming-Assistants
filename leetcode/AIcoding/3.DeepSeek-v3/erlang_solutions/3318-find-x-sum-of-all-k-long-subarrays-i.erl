-spec sum_of_subarrays(Nums :: [integer()], K :: integer(), X :: integer()) -> integer().
sum_of_subarrays(Nums, K, X) ->
    Subarrays = get_subarrays(Nums, K),
    Sums = lists:map(fun(Sub) -> lists:sum(Sub) end, Subarrays),
    Sorted = lists:sort(Sums),
    lists:sum(lists:sublist(Sorted, X)).

get_subarrays(Nums, K) ->
    get_subarrays(Nums, K, length(Nums) - K + 1, []).

get_subarrays(_, _, 0, Acc) ->
    lists:reverse(Acc);
get_subarrays([H | T], K, Count, Acc) ->
    Sub = lists:sublist([H | T], K),
    get_subarrays(T, K, Count - 1, [Sub | Acc]).