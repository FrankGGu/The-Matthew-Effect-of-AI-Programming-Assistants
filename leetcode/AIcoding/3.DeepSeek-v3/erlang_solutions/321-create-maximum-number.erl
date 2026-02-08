-spec max_number(Nums1 :: [integer()], Nums2 :: [integer()], K :: integer()) -> [integer()].
max_number(Nums1, Nums2, K) ->
    Max = lists:foldl(fun(I, Acc) ->
        A = max_subsequence(Nums1, I),
        B = max_subsequence(Nums2, K - I),
        Merged = merge(A, B),
        case compare(Merged, Acc) of
            true -> Merged;
            false -> Acc
        end
    end, [], lists:seq(max(0, K - length(Nums2)), min(K, length(Nums1)))),
    Max.

max_subsequence(Nums, K) ->
    Drop = length(Nums) - K,
    lists:foldl(fun(X, Acc) ->
        case Drop > 0 andalso Acc =/= [] andalso hd(Acc) < X of
            true -> max_subsequence(tl(Acc) ++ [X], Drop - 1);
            false -> [X | Acc]
        end
    end, [], Nums).

merge(A, B) ->
    lists:reverse(merge_helper(A, B, [])).

merge_helper([], B, Acc) ->
    lists:reverse(B) ++ Acc;
merge_helper(A, [], Acc) ->
    lists:reverse(A) ++ Acc;
merge_helper([X | Xs], [Y | Ys], Acc) ->
    case compare([X | Xs], [Y | Ys]) of
        true -> merge_helper(Xs, [Y | Ys], [X | Acc]);
        false -> merge_helper([X | Xs], Ys, [Y | Acc])
    end.

compare([], _) -> false;
compare(_, []) -> true;
compare([X | Xs], [Y | Ys]) ->
    if
        X > Y -> true;
        X < Y -> false;
        true -> compare(Xs, Ys)
    end.