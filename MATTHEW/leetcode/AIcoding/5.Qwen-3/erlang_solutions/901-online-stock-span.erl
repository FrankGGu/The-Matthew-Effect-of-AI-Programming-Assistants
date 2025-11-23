-module(online_stock_span).
-export([init/0, next/2]).

-record(state, {stack = [], result = []}).

init() ->
    #state{}.

next(Price, State) ->
    Stack = State#state.stack,
    Result = State#state.result,
    NewStack = [],
    NewResult = [],
    Span = 0,
    case Stack of
        [] ->
            NewStack1 = [{Price, 1}],
            NewResult1 = [1],
            {1, State#state{stack = NewStack1, result = NewResult1}};
        _ ->
            {Span1, NewStack1, NewResult1} = process(Stack, Price, 1, Result),
            {Span1, State#state{stack = NewStack1, result = NewResult1}}
    end.

process([], Price, Count, Result) ->
    {Count, [{Price, Count}], [Count]};
process([{P, C} | T], Price, Count, Result) when P > Price ->
    {Count, [{Price, Count} | [{P, C} | T]], [Count | Result]};
process([{P, C} | T], Price, Count, Result) ->
    process(T, Price, Count + C, Result).