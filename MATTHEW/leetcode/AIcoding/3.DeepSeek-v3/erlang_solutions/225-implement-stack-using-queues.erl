-module(stack).

-export([new/0, push/2, pop/1, top/1, empty/1]).

new() -> 
    {queue:new(), queue:new()}.

push({Q1, Q2}, X) -> 
    queue:in(X, Q1),
    {Q1, Q2}.

pop({Q1, Q2}) ->
    case queue:is_empty(Q1) of
        true -> 
            {error, empty};
        false ->
            {Q, Last} = pop_last(Q1),
            {Q, Q2}
    end.

top({Q1, _Q2}) ->
    case queue:is_empty(Q1) of
        true -> 
            {error, empty};
        false ->
            {_Q, Last} = pop_last(Q1),
            {queue:in(Last, Q1), Last}
    end.

empty({Q1, _Q2}) ->
    queue:is_empty(Q1).

pop_last(Q) ->
    case queue:out(Q) of
        {{value, X}, QRest} ->
            case queue:is_empty(QRest) of
                true -> 
                    {queue:new(), X};
                false ->
                    {QFinal, Last} = pop_last(QRest),
                    {queue:in(X, QFinal), Last}
            end;
        {empty, _} ->
            {error, empty}
    end.