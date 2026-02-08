-module(moving_average).
-export([new/1, next/2]).

new(Size) ->
    {queue:new(), 0, Size, 0.0}.

next({Queue, Sum, Size, Avg}, Val) ->
    case queue:len(Queue) == Size of
        true ->
            {First, NewQueue} = queue:out(Queue),
            NewSum = Sum - First + Val,
            NewAvg = NewSum / Size,
            {queue:in(Val, NewQueue), NewSum, Size, NewAvg};
        false ->
            NewQueue = queue:in(Val, Queue),
            NewSum = Sum + Val,
            NewAvg = NewSum / queue:len(NewQueue),
            {NewQueue, NewSum, Size, NewAvg}
    end.