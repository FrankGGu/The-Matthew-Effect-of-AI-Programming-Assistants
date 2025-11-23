-module(circular_queue).
-export([new/1, en_queue/2, de_queue/1, front/1, rear/1, is_empty/1, is_full/1]).

-record(queue, {size, front, rear, elements}).

new(K) ->
    #queue{size = K, front = 0, rear = 0, elements = array:new(K, {default, undefined})}.

en_queue(Q = #queue{size = Size, front = Front, rear = Rear, elements = Elements}, Value) ->
    case is_full(Q) of
        true -> {false, Q};
        false ->
            NewElements = array:set(Rear, Value, Elements),
            NewRear = (Rear + 1) rem Size,
            {true, Q#queue{rear = NewRear, elements = NewElements}}
    end.

de_queue(Q = #queue{size = Size, front = Front, elements = Elements}) ->
    case is_empty(Q) of
        true -> {false, Q};
        false ->
            NewFront = (Front + 1) rem Size,
            {true, Q#queue{front = NewFront}}
    end.

front(#queue{front = Front, elements = Elements}) ->
    case array:get(Front, Elements) of
        undefined -> -1;
        Value -> Value
    end.

rear(#queue{size = Size, front = Front, rear = Rear, elements = Elements}) ->
    case is_empty(#queue{size = Size, front = Front, rear = Rear, elements = Elements}) of
        true -> -1;
        false ->
            Pos = if
                Rear == 0 -> Size - 1;
                true -> Rear - 1
            end,
            case array:get(Pos, Elements) of
                undefined -> -1;
                Value -> Value
            end
    end.

is_empty(#queue{front = Front, rear = Rear}) ->
    Front == Rear.

is_full(#queue{size = Size, front = Front, rear = Rear}) ->
    (Rear + 1) rem Size == Front.