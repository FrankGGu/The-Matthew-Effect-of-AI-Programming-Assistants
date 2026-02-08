-module(circular_queue).
-export([new/1, enQueue/2, deQueue/2, Front/1, Rear/1, isEmpty/1, isFull/1]).

new(Size) ->
    {queue, [], [], Size}.

enQueue(Q, Value) ->
    {queue, In, Out, Size} = Q,
    case isFull(Q) of
        true -> false;
        false ->
            NewIn = [Value | In],
            {queue, NewIn, Out, Size}
    end.

deQueue(Q) ->
    {queue, In, Out, Size} = Q,
    case isEmpty(Q) of
        true -> false;
        false ->
            NewOut = tl(Out),
            {queue, In, NewOut, Size}
    end.

Front(Q) ->
    {queue, In, Out, _} = Q,
    case isEmpty(Q) of
        true -> -1;
        false -> hd(Out)
    end.

Rear(Q) ->
    {queue, In, Out, _} = Q,
    case isEmpty(Q) of
        true -> -1;
        false -> lists:last(In)
    end.

isEmpty(Q) ->
    {queue, In, Out, _} = Q,
    In == [] andalso Out == [].

isFull(Q) ->
    {queue, In, Out, Size} = Q,
    length(In) + length(Out) == Size.