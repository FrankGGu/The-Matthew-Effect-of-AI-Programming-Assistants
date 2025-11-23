-module(moving_average).
-export([init/1, next/2]).

-record(state, {size, queue, sum}).

init(Size) ->
    #state{size = Size, queue = queue:new(), sum = 0}.

next(Val, State = #state{size = Size, queue = Q, sum = Sum}) ->
    NewQ = queue:in(Val, Q),
    NewSum = Sum + Val,
    case queue:len(NewQ) =< Size of
        true ->
            {NewSum / queue:len(NewQ), State#state{queue = NewQ, sum = NewSum}};
        false ->
            {OldVal, UpdatedQ} = queue:out(NewQ),
            UpdatedSum = NewSum - OldVal,
            {UpdatedSum / Size, State#state{queue = UpdatedQ, sum = UpdatedSum}}
    end.