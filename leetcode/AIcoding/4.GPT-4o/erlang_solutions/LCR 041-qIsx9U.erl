-module(MovingAverage).
-export([new/1, next/2]).

-record(state, {size, queue = []}).

new(Size) ->
    #state{size = Size}.

next(State, Value) ->
    Queue = State#state.queue,
    NewQueue = lists:append(Queue, [Value]),
    NewQueue1 = if length(NewQueue) > State#state.size -> tl(NewQueue); true -> NewQueue end,
    Average = lists:sum(NewQueue1) / length(NewQueue1),
    {Average, State#state{queue = NewQueue1}}.