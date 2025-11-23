-spec kth_largest(Arr :: [unicode:unicode_binary()], K :: integer()) -> unicode:unicode_binary().
kth_largest(Arr, K) ->
    Nums = lists:map(fun binary_to_integer/1, Arr),
    Sorted = lists:sort(fun(A, B) -> A > B end, Nums),
    integer_to_binary(lists:nth(K, Sorted)).