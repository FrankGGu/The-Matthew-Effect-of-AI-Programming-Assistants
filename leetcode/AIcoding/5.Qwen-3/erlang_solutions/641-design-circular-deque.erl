-module(my_circular_deque).
-export([new/1, insertFront/2, insertLast/2, deleteFront/1, deleteLast/1, getFront/1, getRear/1, isEmpty/1, isFull/1]).

-record(deque, {capacity, size, data, front, rear}).

new(Capacity) ->
    #deque{capacity = Capacity, size = 0, data = erlang:list_to_tuple(lists:duplicate(Capacity, undefined)), front = 0, rear = 0}.

insertFront(Dq, Value) ->
    case isFull(Dq) of
        true -> false;
        false ->
            Front = (Dq#deque.front - 1 + Dq#deque.capacity) rem Dq#deque.capacity,
            Data = array:set(Front, Value, Dq#deque.data),
            Dq#deque{front = Front, data = Data, size = Dq#deque.size + 1}
    end.

insertLast(Dq, Value) ->
    case isFull(Dq) of
        true -> false;
        false ->
            Rear = (Dq#deque.rear + 1) rem Dq#deque.capacity,
            Data = array:set(Dq#deque.rear, Value, Dq#deque.data),
            Dq#deque{rear = Rear, data = Data, size = Dq#deque.size + 1}
    end.

deleteFront(Dq) ->
    case isEmpty(Dq) of
        true -> false;
        false ->
            NewFront = (Dq#deque.front + 1) rem Dq#deque.capacity,
            Data = array:set(Dq#deque.front, undefined, Dq#deque.data),
            Dq#deque{front = NewFront, data = Data, size = Dq#deque.size - 1}
    end.

deleteLast(Dq) ->
    case isEmpty(Dq) of
        true -> false;
        false ->
            NewRear = (Dq#deque.rear - 1 + Dq#deque.capacity) rem Dq#deque.capacity,
            Data = array:set(Dq#deque.rear, undefined, Dq#deque.data),
            Dq#deque{rear = NewRear, data = Data, size = Dq#deque.size - 1}
    end.

getFront(Dq) ->
    case isEmpty(Dq) of
        true -> undefined;
        false -> array:get(Dq#deque.front, Dq#deque.data)
    end.

getRear(Dq) ->
    case isEmpty(Dq) of
        true -> undefined;
        false -> array:get(Dq#deque.rear, Dq#deque.data)
    end.

isEmpty(Dq) ->
    Dq#deque.size == 0.

isFull(Dq) ->
    Dq#deque.size == Dq#deque.capacity.