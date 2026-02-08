-module(circular_deque).
-export([new/1, insert_front/2, insert_last/2, delete_front/1, delete_last/1, get_front/1, get_rear/1, is_empty/1, is_full/1]).

-record(deque, {capacity, size, front, rear, elements}).

new(K) ->
    #deque{capacity = K, size = 0, front = 0, rear = K - 1, elements = array:new(K, {default, -1})}.

insert_front(Deque = #deque{capacity = C, size = S, front = F, elements = E}, Value) ->
    case is_full(Deque) of
        true -> false;
        false ->
            NewFront = (F - 1 + C) rem C,
            NewElements = array:set(NewFront, Value, E),
            {true, Deque#deque{size = S + 1, front = NewFront, elements = NewElements}}
    end.

insert_last(Deque = #deque{capacity = C, size = S, rear = R, elements = E}, Value) ->
    case is_full(Deque) of
        true -> false;
        false ->
            NewRear = (R + 1) rem C,
            NewElements = array:set(NewRear, Value, E),
            {true, Deque#deque{size = S + 1, rear = NewRear, elements = NewElements}}
    end.

delete_front(Deque = #deque{capacity = C, size = S, front = F, elements = E}) ->
    case is_empty(Deque) of
        true -> false;
        false ->
            NewFront = (F + 1) rem C,
            {true, Deque#deque{size = S - 1, front = NewFront}}
    end.

delete_last(Deque = #deque{capacity = C, size = S, rear = R, elements = E}) ->
    case is_empty(Deque) of
        true -> false;
        false ->
            NewRear = (R - 1 + C) rem C,
            {true, Deque#deque{size = S - 1, rear = NewRear}}
    end.

get_front(#deque{size = 0}) -> -1;
get_front(#deque{front = F, elements = E}) -> array:get(F, E).

get_rear(#deque{size = 0}) -> -1;
get_rear(#deque{rear = R, elements = E}) -> array:get(R, E).

is_empty(#deque{size = 0}) -> true;
is_empty(_) -> false.

is_full(#deque{size = S, capacity = C}) -> S == C.