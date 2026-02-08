-spec k_smallest_pairs(Nums1 :: [integer()], Nums2 :: [integer()], K :: integer()) -> [[integer()]].
k_smallest_pairs(Nums1, Nums2, K) ->
    case {Nums1, Nums2} of
        {[], _} -> [];
        {_, []} -> [];
        _ ->
            Heap = create_heap(Nums1, Nums2, K),
            get_k_smallest(Heap, K)
    end.

create_heap(Nums1, Nums2, K) ->
    Heap0 = heap:new(fun([A, B], [C, D]) -> (A + B) =< (C + D) end),
    lists:foldl(fun(I, Heap) ->
        lists:foldl(fun(J, H) ->
            case heap:size(H) < K of
                true -> heap:insert([lists:nth(I, Nums1), lists:nth(J, Nums2)], H);
                false ->
                    [Top | _] = heap:peek(H),
                    Sum = lists:nth(I, Nums1) + lists:nth(J, Nums2),
                    if
                        Sum < lists:sum(Top) ->
                            heap:insert([lists:nth(I, Nums1), lists:nth(J, Nums2)], heap:delete(H));
                        true -> H
                    end
            end
        end, Heap, lists:seq(1, min(length(Nums2), K)))
    end, Heap0, lists:seq(1, min(length(Nums1), K))).

get_k_smallest(Heap, K) ->
    case heap:is_empty(Heap) of
        true -> [];
        false ->
            case K =< 0 of
                true -> [];
                false ->
                    {[Pair | _], NewHeap} = heap:take(Heap),
                    [Pair | get_k_smallest(NewHeap, K - 1)]
            end
    end.