-spec min_swap(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
min_swap(Nums1, Nums2) ->
    {Keep, Swap} = lists:foldl(fun(I, {KeepPrev, SwapPrev}) ->
        Keep = erlang:max(KeepPrev, SwapPrev),
        Swap = Keep,
        case (I > 0 andalso (lists:nth(I, Nums1) =< lists:nth(I - 1, Nums1) orelse lists:nth(I, Nums2) =< lists:nth(I - 1, Nums2))) of
            true ->
                NewKeep = KeepPrev,
                NewSwap = SwapPrev + 1,
                {NewKeep, NewSwap};
            false ->
                case (I > 0 andalso (lists:nth(I, Nums1) > lists:nth(I - 1, Nums2) andalso lists:nth(I, Nums2) > lists:nth(I - 1, Nums1)) of
                    true ->
                        NewKeep1 = min(KeepPrev, SwapPrev),
                        NewSwap1 = min(SwapPrev, KeepPrev) + 1,
                        {NewKeep1, NewSwap1};
                    false ->
                        NewKeep2 = KeepPrev,
                        NewSwap2 = SwapPrev + 1,
                        {NewKeep2, NewSwap2}
                end
        end
    end, {0, 1}, lists:seq(1, length(Nums1) - 1)),
    min(Keep, Swap).