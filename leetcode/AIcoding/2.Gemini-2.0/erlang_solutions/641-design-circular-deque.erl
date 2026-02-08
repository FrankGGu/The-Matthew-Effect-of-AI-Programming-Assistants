-module(circular_deque).
-export([new, insertFront, insertLast, deleteFront, deleteLast, getFront, getRear, isEmpty, isFull]).

-record(deque, {
    deque_list = [],
    capacity = 0,
    size = 0
}).

new(K) ->
    #deque{capacity = K}.

insertFront(Deque, Value) ->
    case Deque#deque.size < Deque#deque.capacity of
        true ->
            NewDequeList = [Value | Deque#deque.deque_list],
            NewDeque = Deque#deque{deque_list = NewDequeList, size = Deque#deque.size + 1},
            {true, NewDeque};
        false ->
            {false, Deque}
    end.

insertLast(Deque, Value) ->
    case Deque#deque.size < Deque#deque.capacity of
        true ->
            NewDequeList = Deque#deque.deque_list ++ [Value],
            NewDeque = Deque#deque{deque_list = NewDequeList, size = Deque#deque.size + 1},
            {true, NewDeque};
        false ->
            {false, Deque}
    end.

deleteFront(Deque) ->
    case Deque#deque.size > 0 of
        true ->
            [_ | Rest] = Deque#deque.deque_list,
            NewDeque = Deque#deque{deque_list = Rest, size = Deque#deque.size - 1},
            {true, NewDeque};
        false ->
            {false, Deque}
    end.

deleteLast(Deque) ->
    case Deque#deque.size > 0 of
        true ->
            {NewDequeList, _} = lists:droplast(Deque#deque.deque_list),
            NewDeque = Deque#deque{deque_list = NewDequeList, size = Deque#deque.size - 1},
            {true, NewDeque};
        false ->
            {false, Deque}
    end.

getFront(Deque) ->
    case Deque#deque.size > 0 of
        true ->
            [Front | _] = Deque#deque.deque_list,
            {true, Front};
        false ->
            {false, -1}
    end.

getRear(Deque) ->
    case Deque#deque.size > 0 of
        true ->
            {_, Rear} = lists:last(Deque#deque.deque_list),
            {true, Rear};
        false ->
            {false, -1}
    end.

isEmpty(Deque) ->
    Deque#deque.size == 0.

isFull(Deque) ->
    Deque#deque.size == Deque#deque.capacity.

lists:droplast(L) ->
    droplast(L, []).

droplast([H], Acc) ->
    {lists:reverse(Acc), H};
droplast([H|T], Acc) ->
    droplast(T, [H|Acc]).