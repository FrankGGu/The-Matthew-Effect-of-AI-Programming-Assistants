-module(CircularDeque).
-export([new/1, insert_front/2, insert_last/2, delete_front/1, delete_last/1, get_front/1, get_rear/1, is_empty/1, is_full/1]).

-record(deque, {capacity, front, rear, size, data}).

new(Capacity) ->
    #deque{capacity = Capacity, front = 0, rear = 0, size = 0, data = lists:duplicate(Capacity, undefined)}.

insert_front(Deque, Value) ->
    if
        Deque#deque.size < Deque#deque.capacity ->
            NewFront = (Deque#deque.front - 1 + Deque#deque.capacity) rem Deque#deque.capacity,
            NewData = lists:replace(NewFront, Value, Deque#deque.data),
            #deque{Deque | front = NewFront, size = Deque#deque.size + 1, data = NewData};
        true -> 
            Deque
    end.

insert_last(Deque, Value) ->
    if
        Deque#deque.size < Deque#deque.capacity ->
            NewRear = (Deque#deque.rear + 1) rem Deque#deque.capacity,
            NewData = lists:replace(Deque#deque.rear, Value, Deque#deque.data),
            #deque{Deque | rear = NewRear, size = Deque#deque.size + 1, data = NewData};
        true -> 
            Deque
    end.

delete_front(Deque) ->
    if
        Deque#deque.size > 0 ->
            NewFront = (Deque#deque.front + 1) rem Deque#deque.capacity,
            #deque{Deque | front = NewFront, size = Deque#deque.size - 1};
        true -> 
            Deque
    end.

delete_last(Deque) ->
    if
        Deque#deque.size > 0 ->
            NewRear = (Deque#deque.rear - 1 + Deque#deque.capacity) rem Deque#deque.capacity,
            #deque{Deque | rear = NewRear, size = Deque#deque.size - 1};
        true -> 
            Deque
    end.

get_front(Deque) ->
    if
        Deque#deque.size > 0 ->
            Deque#deque.data.element(Deque#deque.front);
        true -> 
            undefined
    end.

get_rear(Deque) ->
    if
        Deque#deque.size > 0 ->
            Deque#deque.data.element((Deque#deque.rear - 1 + Deque#deque.capacity) rem Deque#deque.capacity);
        true -> 
            undefined
    end.

is_empty(Deque) ->
    Deque#deque.size == 0.

is_full(Deque) ->
    Deque#deque.size == Deque#deque.capacity.