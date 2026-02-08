-spec min_operations(nums1 :: [integer()], nums2 :: [integer()]) -> integer().
min_operations(Nums1, Nums2) ->
    N = length(Nums1),
    Last1 = lists:nth(N, Nums1),
    Last2 = lists:nth(N, Nums2),

    {Swap, NoSwap} = lists:foldl(fun(I, {SwapAcc, NoSwapAcc}) ->
        X1 = lists:nth(I, Nums1),
        Y1 = lists:nth(I, Nums2),
        X2 = lists:nth(I, Nums2),
        Y2 = lists:nth(I, Nums1),

        NewNoSwap = if
            (X1 =< Last1) and (Y1 =< Last2) -> NoSwapAcc;
            true -> infinity
        end,

        NewSwap = if
            (X2 =< Last1) and (Y2 =< Last2) -> min(SwapAcc, NoSwapAcc + 1);
            true -> SwapAcc
        end,

        NewNoSwap2 = if
            (X1 =< Last2) and (Y1 =< Last1) -> min(NoSwapAcc, SwapAcc + 1);
            true -> NewNoSwap
        end,

        NewSwap2 = if
            (X2 =< Last2) and (Y2 =< Last1) -> min(SwapAcc, SwapAcc + 1);
            true -> NewSwap
        end,

        {NewSwap2, NewNoSwap2}
    end, {0, 0}, lists:seq(1, N - 1)),

    case min(Swap, NoSwap) of
        infinity -> -1;
        Res -> Res
    end.