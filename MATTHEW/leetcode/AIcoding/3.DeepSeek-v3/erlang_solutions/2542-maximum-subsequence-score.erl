-module(max_subseq_score).
-export([max_score/2]).

max_score(Nums1, Nums2) ->
    Pairs = lists:zip(lists:reverse(lists:sort(Nums2)), lists:reverse(lists:sort(Nums1))),
    {_, Sum, Heap} = lists:foldl(fun({B, A}, {K, Sum, Heap}) ->
        case K > 0 of
            true ->
                NewSum = Sum + A,
                case heap:size(Heap) < K of
                    true -> 
                        NewHeap = heap:insert(A, Heap),
                        {K, NewSum, NewHeap};
                    false ->
                        case heap:size(Heap) == K of
                            true ->
                                case heap:peek(Heap) < A of
                                    true ->
                                        {Min, TmpHeap} = heap:take(Heap),
                                        NewHeap = heap:insert(A, TmpHeap),
                                        NewSum1 = Sum - Min + A,
                                        {K, NewSum1, NewHeap};
                                    false ->
                                        {K, Sum, Heap}
                                end;
                            false ->
                                {K, Sum, Heap}
                        end
                end;
            false ->
                {K, Sum, Heap}
        end
    end, {length(Nums1), 0, heap:new(max)}, Pairs),
    Sum.