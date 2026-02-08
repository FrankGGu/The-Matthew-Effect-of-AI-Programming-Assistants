-module(solution).
-export([get_order/1]).

get_order(Tasks) ->
    IndexedTasks = lists:zip(lists:seq(0, length(Tasks) - 1), Tasks),
    SortedTasks = lists:sort(fun([_, [A, _]], [_, [B, _]]) -> A =< B end, IndexedTasks),
    schedule(SortedTasks, [], 0, []).

schedule([], [], _, Result) ->
    lists:reverse(Result);
schedule([], Heap, Time, Result) ->
    {[Index, [_, P]], NewHeap} = get_min(Heap),
    NewTime = Time + P,
    schedule([], NewHeap, NewTime, [Index | Result]);
schedule([[Index, [E, P]] | Rest], Heap, Time, Result) when E =< Time ->
    NewHeap = insert(Heap, Index, [E, P]),
    schedule(Rest, NewHeap, Time, Result);
schedule([[Index, [E, P]] | Rest], Heap, Time, Result) ->
    case Heap of
        [] ->
            NewTime = E,
            NewHeap = insert([], Index, [E, P]),
            schedule(Rest, NewHeap, NewTime, Result);
        _ ->
            {[MinIndex, [_, MinP]], NewHeap} = get_min(Heap),
            NewTime = Time + MinP,
            NewHeap2 = insert(NewHeap, Index, [E, P]),
            schedule(Rest, NewHeap2, NewTime, [MinIndex | Result])
    end.

insert(Heap, Index, Task) ->
    lists:sort(fun([_, [_, A]], [_, [_, B]]) -> A =< B end, [[Index, Task] | Heap]).

get_min(Heap) ->
    [Min | Rest] = Heap,
    {Min, Rest}.