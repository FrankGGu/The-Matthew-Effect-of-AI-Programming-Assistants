-module(circular_queue).
-export([new/1, en_queue/2, de_queue/1, front/1, rear/1, is_empty/1, is_full/1]).

-record(queue, {
    data = [],
    head = 0,
    tail = 0,
    capacity = 0
}).

new(K) ->
    #queue{capacity = K}.

en_queue(Q, Value) ->
    case is_full(Q) of
        true ->
            Q;
        false ->
            Capacity = Q#queue.capacity,
            Tail = Q#queue.tail,
            NewTail = (Tail + 1) rem Capacity,
            Data = lists:nthreplace(NewTail + 1, Value, Q#queue.data),
            Q#queue{tail = NewTail, data = Data}
    end.

de_queue(Q) ->
    case is_empty(Q) of
        true ->
            false;
        false ->
            Capacity = Q#queue.capacity,
            Head = Q#queue.head,
            NewHead = (Head + 1) rem Capacity,
            Q#queue{head = NewHead}
    end.

front(Q) ->
    case is_empty(Q) of
        true ->
            -1;
        false ->
            Head = Q#queue.head,
            lists:nth(Head + 1, Q#queue.data)
    end.

rear(Q) ->
    case is_empty(Q) of
        true ->
            -1;
        false ->
            Tail = Q#queue.tail,
            lists:nth(Tail + 1, Q#queue.data)
    end.

is_empty(Q) ->
    Q#queue.head =:= Q#queue.tail.

is_full(Q) ->
    Capacity = Q#queue.capacity,
    Head = Q#queue.head,
    Tail = Q#queue.tail,
    ((Tail + 1) rem Capacity) =:= Head.