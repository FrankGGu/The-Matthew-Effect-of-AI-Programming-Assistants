-spec count_range_sum(Nums :: [integer()], Lower :: integer(), Upper :: integer()) -> integer().
count_range_sum(Nums, Lower, Upper) ->
    N = length(Nums),
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Nums),
    Sorted = lists:reverse(Prefix),
    {Count, _} = merge_sort(Sorted, Lower, Upper),
    Count.

merge_sort(List, Lower, Upper) ->
    case List of
        [] -> {0, []};
        [X] -> {0, [X]};
        _ ->
            {Left, Right} = lists:split(length(List) div 2, List),
            {Count1, L} = merge_sort(Left, Lower, Upper),
            {Count2, R} = merge_sort(Right, Lower, Upper),
            {Count3, Merged} = merge(L, R, Lower, Upper),
            {Count1 + Count2 + Count3, Merged}
    end.

merge(Left, Right, Lower, Upper) ->
    Count = 0,
    I = 0,
    J = 0,
    K = 0,
    {Count1, _} = count_while_merge(Left, Right, Lower, Upper, Count, I, J, K),
    Merged = lists:merge(fun(A, B) -> A =< B end, Left, Right),
    {Count1, Merged}.

count_while_merge(Left, Right, Lower, Upper, Count, I, J, K) ->
    case {I < length(Left), J < length(Right)} of
        {true, true} ->
            L = lists:nth(I + 1, Left),
            R = lists:nth(J + 1, Right),
            if
                R - L >= Lower, R - L =< Upper ->
                    count_while_merge(Left, Right, Lower, Upper, Count + 1, I, J + 1, K + 1);
                R - L < Lower ->
                    count_while_merge(Left, Right, Lower, Upper, Count, I, J + 1, K + 1);
                true ->
                    count_while_merge(Left, Right, Lower, Upper, Count, I + 1, J, K + 1)
            end;
        {true, false} ->
            {Count, K};
        {false, true} ->
            {Count, K};
        {false, false} ->
            {Count, K}
    end.