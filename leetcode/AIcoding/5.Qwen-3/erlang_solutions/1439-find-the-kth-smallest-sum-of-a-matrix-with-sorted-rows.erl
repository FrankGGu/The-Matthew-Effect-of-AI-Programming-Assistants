-module(kth_smallest_sum).
-export([kthSmallestSum/2]).

kthSmallestSum(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MinHeap = lists:foldl(fun(Row, Acc) -> 
        {lists:nth(1, Row), 0, Row} ++ Acc
    end, [], Matrix),
    SortedHeap = lists:sort(MinHeap),
    kthSmallest(SortedHeap, K, Rows, Cols).

kthSmallest(_, 1, _, _) ->
    element(1, hd([]));
kthSmallest([], _, _, _) ->
    0;
kthSmallest([{Val, Col, Row} | Rest], K, Rows, Cols) ->
    if
        K == 1 ->
            Val;
        true ->
            NextCol = Col + 1,
            NextVal = if
                NextCol < Cols ->
                    lists:nth(NextCol + 1, Row);
                true ->
                    infinity
            end,
            NewHeap = lists:merge([{NextVal, NextCol, Row} | Rest], lists:tl(hd(lists:split(1, [Val | Rest])))),
            kthSmallest(NewHeap, K - 1, Rows, Cols)
    end.