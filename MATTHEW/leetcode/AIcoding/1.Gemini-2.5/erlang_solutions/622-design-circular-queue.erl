new(K) ->
    Array = list_to_tuple(lists:duplicate(K, undefined)),
    #{array => Array, head => 0, tail => 0, count => 0, capacity => K}.

enQueue(Queue, Value) ->
    case isFull(Queue) of
        true ->
            {false, Queue};
        false ->
            Array = maps:get(array, Queue),
            Tail = maps:get(tail, Queue),
            Capacity = maps:get(capacity, Queue),

            NewArray = setelement(Tail + 1, Array, Value),
            NewTail = (Tail + 1) rem Capacity,
            NewCount = maps:get(count, Queue) + 1,

            {true, Queue#{array := NewArray, tail := NewTail, count := NewCount}}
    end.

deQueue(Queue) ->
    case isEmpty(Queue) of
        true ->
            {false, Queue};
        false ->
            Head = maps:get(head, Queue),
            Capacity = maps:get(capacity, Queue),

            NewHead = (Head + 1) rem Capacity,
            NewCount = maps:get(count, Queue) - 1,

            {true, Queue#{head := NewHead, count := NewCount}}
    end.

front(Queue) ->
    case isEmpty(Queue) of
        true ->
            -1;
        false ->
            Array = maps:get(array, Queue),
            Head = maps:get(head, Queue),
            element(Head + 1, Array)
    end.

rear(Queue) ->
    case isEmpty(Queue) of
        true ->
            -1;
        false ->
            Array = maps:get(array, Queue),
            Tail = maps:get(tail, Queue),
            Capacity = maps:get(capacity, Queue),

            ActualRearIndex = (Tail - 1 + Capacity) rem Capacity,
            element(ActualRearIndex + 1, Array)
    end.

isEmpty(Queue) ->
    maps:get(count, Queue) == 0.

isFull(Queue) ->
    maps:get(count, Queue) == maps:get(capacity, Queue).