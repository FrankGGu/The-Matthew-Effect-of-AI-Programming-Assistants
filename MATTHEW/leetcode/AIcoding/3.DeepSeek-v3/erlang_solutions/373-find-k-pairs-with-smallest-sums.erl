-spec k_smallest_pairs(Nums1 :: [integer()], Nums2 :: [integer()], K :: integer()) -> [[integer()]].
k_smallest_pairs(Nums1, Nums2, K) ->
    case {Nums1, Nums2} of
        {[], _} -> [];
        {_, []} -> [];
        _ ->
            Heap = heap:new(),
            lists:foreach(fun(X) -> heap:insert(Heap, {X + hd(Nums2), [X, hd(Nums2)]}) end, Nums1),
            Result = k_smallest_pairs_loop(Heap, tl(Nums2), K - 1, [[hd(Nums1), hd(Nums2)]]),
            lists:reverse(Result)
    end.

k_smallest_pairs_loop(_, _, 0, Acc) -> Acc;
k_smallest_pairs_loop(Heap, [], K, Acc) ->
    case heap:is_empty(Heap) of
        true -> Acc;
        false ->
            {_, [X, Y]} = heap:extract_min(Heap),
            k_smallest_pairs_loop(Heap, [], K - 1, [[X, Y] | Acc])
    end;
k_smallest_pairs_loop(Heap, [Y | Ys], K, Acc) ->
    case heap:is_empty(Heap) of
        true -> Acc;
        false ->
            {Sum, [X, _]} = heap:extract_min(Heap),
            NewHeap = heap:insert(Heap, {X + Y, [X, Y]}),
            k_smallest_pairs_loop(NewHeap, Ys, K - 1, [[X, Y] | Acc])
    end.