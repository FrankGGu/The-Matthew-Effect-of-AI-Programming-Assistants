-module(my_circular_deque).
-export([new/1, insertFront/2, insertLast/2, deleteFront/1, deleteLast/1, getFront/1, getRear/1, isEmpty/1, isFull/1]).

-record(my_circular_deque, {
    capacity :: integer(),
    size :: integer(),
    front :: integer(), % Logical index (0 to capacity-1) of the front element
    rear :: integer(),  % Logical index (0 to capacity-1) where the next element would be inserted at the rear
    data :: tuple()     % Underlying storage, 1-indexed tuple
}).

new(K) ->
    #my_circular_deque{
        capacity = K,
        size = 0,
        front = 0,
        rear = 0,
        data = list_to_tuple(lists:duplicate(K, undefined))
    }.

insertFront(Value, #my_circular_deque{capacity = Capacity, size = Size, front = Front, data = Data} = Deque) ->
    case Size == Capacity of
        true -> {false, Deque};
        false ->
            NewFront = (Front - 1 + Capacity) rem Capacity,
            NewData = setelement(NewFront + 1, Data, Value),
            NewSize = Size + 1,
            {true, Deque#my_circular_deque{front = NewFront, size = NewSize, data = NewData}}
    end.

insertLast(Value, #my_circular_deque{capacity = Capacity, size = Size, rear = Rear, data = Data} = Deque) ->
    case Size == Capacity of
        true -> {false, Deque};
        false ->
            NewData = setelement(Rear + 1, Data, Value),
            NewRear = (Rear + 1) rem Capacity,
            NewSize = Size + 1,
            {true, Deque#my_circular_deque{rear = NewRear, size = NewSize, data = NewData}}
    end.

deleteFront(#my_circular_deque{capacity = Capacity, size = Size, front = Front} = Deque) ->
    case Size == 0 of
        true -> {false, Deque};
        false ->
            NewFront = (Front + 1) rem Capacity,
            NewSize = Size - 1,
            {true, Deque#my_circular_deque{front = NewFront, size = NewSize}}
    end.

deleteLast(#my_circular_deque{capacity = Capacity, size = Size, rear = Rear} = Deque) ->
    case Size == 0 of
        true -> {false, Deque};
        false ->
            NewRear = (Rear - 1 + Capacity) rem Capacity,
            NewSize = Size - 1,
            {true, Deque#my_circular_deque{rear = NewRear, size = NewSize}}
    end.

getFront(#my_circular_deque{size = Size, front = Front, data = Data}) ->
    case Size == 0 of
        true -> -1;
        false -> element(Front + 1, Data)
    end.

getRear(#my_circular_deque{capacity = Capacity, size = Size, rear = Rear, data = Data}) ->
    case Size == 0 of
        true -> -1;
        false ->
            ActualRearIdx = (Rear - 1 + Capacity) rem Capacity,
            element(ActualRearIdx + 1, Data)
    end.

isEmpty(#my_circular_deque{size = Size}) ->
    Size == 0.

isFull(#my_circular_deque{capacity = Capacity, size = Size}) ->
    Size == Capacity.