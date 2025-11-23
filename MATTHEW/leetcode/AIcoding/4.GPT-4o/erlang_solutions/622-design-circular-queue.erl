-module(MyCircularQueue).
-export([new/1, en_queue/2, de_queue/1, front/1, rear/1, is_empty/1, is_full/1]).

-record(queue, {size, front, rear, count, data}).

new(Size) ->
    #queue{size=Size, front=0, rear=-1, count=0, data=lists:duplicate(Size, undefined)}.

en_queue(#queue{size=Size, rear=Rear, count=Count} = Q, Value) when Count < Size ->
    NewRear = (Rear + 1) rem Size,
    NewCount = Count + 1,
    Q#queue{rear=NewRear, count=NewCount, data=lists:replace_element(NewRear + 1, Value, Q#queue.data)}.

de_queue(Q) when Q#queue.count > 0 ->
    NewFront = (Q#queue.front + 1) rem Q#queue.size,
    NewCount = Q#queue.count - 1,
    Q#queue{front=NewFront, count=NewCount}.

front(Q) when Q#queue.count > 0 ->
    Q#queue.data[(Q#queue.front + 1) rem Q#queue.size].

rear(Q) when Q#queue.count > 0 ->
    Q#queue.data[(Q#queue.rear + 1) rem Q#queue.size].

is_empty(Q) ->
    Q#queue.count =:= 0.

is_full(Q) ->
    Q#queue.count =:= Q#queue.size.