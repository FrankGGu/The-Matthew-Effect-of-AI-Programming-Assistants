-module(Solution).
-export([MedianFinder/0]).

-record(median_finder, {min_heap = [], max_heap = []}).

init() ->
    #median_finder{}.

add_num(MF, Num) ->
    NewMF = if
        length(MF#median_finder.max_heap) == 0 orelse Num =< hd(MF#median_finder.max_heap) ->
            NewMaxHeap = [Num | MF#median_finder.max_heap],
            NewMaxHeapSorted = lists:sort(NewMaxHeap),
            {NewMaxHeapSorted, MF#median_finder.min_heap};
        true ->
            NewMinHeap = [Num | MF#median_finder.min_heap],
            NewMinHeapSorted = lists:sort(NewMinHeap),
            {MF#median_finder.max_heap, NewMinHeapSorted}
    end,
    balance(NewMF).

balance(MF) ->
    case length(MF#median_finder.max_heap) - length(MF#median_finder.min_heap) of
        2 ->
            {MaxTop, NewMaxHeap} = lists:split(1, MF#median_finder.max_heap),
            NewMinHeap = [hd(NewMaxHeap) | MF#median_finder.min_heap],
            #median_finder{min_heap = lists:sort(NewMinHeap), max_heap = tl(NewMaxHeap)};
        -2 ->
            {MinTop, NewMinHeap} = lists:split(1, MF#median_finder.min_heap),
            NewMaxHeap = [hd(NewMinHeap) | MF#median_finder.max_heap],
            #median_finder{min_heap = tl(NewMinHeap), max_heap = lists:sort(NewMaxHeap)};
        _ ->
            MF
    end.

find_median(MF) ->
    case length(MF#median_finder.max_heap) - length(MF#median_finder.min_heap) of
        0 ->
            (hd(MF#median_finder.max_heap) + hd(MF#median_finder.min_heap)) / 2;
        1 ->
            hd(MF#median_finder.max_heap);
        -1 ->
            hd(MF#median_finder.min_heap)
    end.

MedianFinder() ->
    MF = init(),
    {MF, fun(MF, Num) -> add_num(MF, Num) end, fun(MF) -> find_median(MF) end}.