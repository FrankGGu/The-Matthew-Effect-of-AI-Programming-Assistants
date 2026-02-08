-module(moving_average_from_data_stream).
-export([new/1, next/2]).

-record(state, {size, queue, sum}).

new(Size) ->
    #state{size = Size, queue = [], sum = 0}.

next(State, Val) ->
    #state{size = Size, queue = Queue, sum = Sum} = State,
    NewSum = Sum + Val,
    NewQueue = [Val | Queue],
    if
        length(NewQueue) > Size ->
            [OldVal | Rest] = lists:reverse(NewQueue),
            NewSum2 = NewSum - OldVal,
            NewQueue2 = lists:reverse(Rest),
            {NewSum2 / Size, #state{size = Size, queue = NewQueue2, sum = NewSum2}};
        true ->
            {NewSum / length(NewQueue), #state{size = Size, queue = NewQueue, sum = NewSum}}
    end.