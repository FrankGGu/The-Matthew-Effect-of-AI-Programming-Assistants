-spec next_permutation(Nums :: [integer()]) -> [integer()].
next_permutation(Nums) ->
    Len = length(Nums),
    case Len =< 1 of
        true -> Nums;
        false ->
            {I, J} = find_swap_indices(Nums, Len),
            Swapped = swap(Nums, I, J),
            reverse_tail(Swapped, I + 1, Len)
    end.

find_swap_indices(Nums, Len) ->
    I = find_decreasing_index(Nums, Len),
    case I =:= -1 of
        true -> {-1, -1};
        false ->
            J = find_greater_index(Nums, I, Len),
            {I, J}
    end.

find_decreasing_index(Nums, Len) ->
    find_decreasing_index(Nums, Len - 2, Len - 1).

find_decreasing_index(_Nums, I, _Prev) when I < 0 -> -1;
find_decreasing_index(Nums, I, Prev) ->
    case lists:nth(I + 1, Nums) < lists:nth(Prev + 1, Nums) of
        true -> I;
        false -> find_decreasing_index(Nums, I - 1, I)
    end.

find_greater_index(Nums, I, Len) ->
    X = lists:nth(I + 1, Nums),
    find_greater_index(Nums, Len - 1, I, X).

find_greater_index(Nums, J, I, X) ->
    case lists:nth(J + 1, Nums) > X of
        true -> J;
        false -> find_greater_index(Nums, J - 1, I, X)
    end.

swap(Nums, I, J) ->
    {BeforeI, [VI | AfterI]} = lists:split(I, Nums),
    {BeforeJ, [VJ | AfterJ]} = lists:split(J - I - 1, AfterI),
    BeforeI ++ [VJ | BeforeJ] ++ [VI | AfterJ].

reverse_tail(Nums, Start, Len) ->
    {Prefix, Suffix} = lists:split(Start, Nums),
    Prefix ++ lists:reverse(Suffix).