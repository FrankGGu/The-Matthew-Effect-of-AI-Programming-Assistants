-module(median_finder).
-export([init/0, add_num/1, find_median/0]).

init() ->
    {[], []}.

add_num(Num, {MaxHeap, MinHeap}) ->
    case {MaxHeap, MinHeap} of
        {[], []} ->
            {[Num], []};
        {_, []} ->
            case Num > hd(MaxHeap) of
                true -> {MaxHeap, [Num]};
                false -> {[Num], MaxHeap}
            end;
        _ ->
            MaxTop = hd(MaxHeap),
            MinTop = hd(MinHeap),
            if
                Num =< MaxTop ->
                    NewMax = insert_max(Num, MaxHeap),
                    balance({NewMax, MinHeap});
                Num >= MinTop ->
                    NewMin = insert_min(Num, MinHeap),
                    balance({MaxHeap, NewMin});
                true ->
                    if
                        length(MaxHeap) =< length(MinHeap) ->
                            NewMax = insert_max(Num, MaxHeap),
                            {NewMax, MinHeap};
                        true ->
                            NewMin = insert_min(Num, MinHeap),
                            {MaxHeap, NewMin}
                    end
            end
    end.

find_median({MaxHeap, MinHeap}) ->
    LenMax = length(MaxHeap),
    LenMin = length(MinHeap),
    if
        LenMax > LenMin -> hd(MaxHeap);
        LenMin > LenMax -> hd(MinHeap);
        true -> (hd(MaxHeap) + hd(MinHeap)) / 2
    end.

insert_max(Num, []) -> [Num];
insert_max(Num, [H|T]) when Num > H -> [Num, H|T];
insert_max(Num, [H|T]) -> [H|insert_max(Num, T)].

insert_min(Num, []) -> [Num];
insert_min(Num, [H|T]) when Num < H -> [Num, H|T];
insert_min(Num, [H|T]) -> [H|insert_min(Num, T)].

balance({MaxHeap, MinHeap}) ->
    LenMax = length(MaxHeap),
    LenMin = length(MinHeap),
    if
        LenMax > LenMin + 1 ->
            [MaxTop|NewMax] = MaxHeap,
            NewMin = insert_min(MaxTop, MinHeap),
            {NewMax, NewMin};
        LenMin > LenMax + 1 ->
            [MinTop|NewMin] = MinHeap,
            NewMax = insert_max(MinTop, MaxHeap),
            {NewMax, NewMin};
        true ->
            {MaxHeap, MinHeap}
    end.