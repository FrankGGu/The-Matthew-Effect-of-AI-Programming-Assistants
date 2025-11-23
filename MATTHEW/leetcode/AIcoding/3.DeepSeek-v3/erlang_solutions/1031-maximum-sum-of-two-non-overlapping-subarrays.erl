-spec max_sum_two_no_overlap(Nums :: [integer()], FirstLen :: integer(), SecondLen :: integer()) -> integer().
max_sum_two_no_overlap(Nums, FirstLen, SecondLen) ->
    Prefix = prefix_sum(Nums),
    MaxFirstLen = max_subarray(Prefix, FirstLen),
    MaxSecondLen = max_subarray(Prefix, SecondLen),
    Max1 = find_max_sum(Prefix, FirstLen, SecondLen, MaxFirstLen),
    Max2 = find_max_sum(Prefix, SecondLen, FirstLen, MaxSecondLen),
    max(Max1, Max2).

prefix_sum(Nums) ->
    lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Nums)).

max_subarray(Prefix, Len) ->
    lists:foldl(fun(I, {Max, Acc}) ->
        Sum = lists:nth(I + 1, Prefix) - lists:nth(I - Len + 1, Prefix),
        {max(Max, Sum), [Sum | Acc]}
    end, {0, []}, lists:seq(Len, length(Prefix) - 1)).

find_max_sum(Prefix, Len1, Len2, MaxLen1) ->
    lists:foldl(fun(I, Max) ->
        Sum = lists:nth(I + 1, Prefix) - lists:nth(I - Len2 + 1, Prefix),
        PrevMax = lists:nth(I - Len2 - Len1 + 1, MaxLen1),
        max(Max, Sum + PrevMax)
    end, 0, lists:seq(Len1 + Len2, length(Prefix) - 1)).