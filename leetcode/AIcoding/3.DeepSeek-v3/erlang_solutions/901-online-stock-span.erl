-module(stock_spanner).
-export([init/0, next/1]).

-record(state, {stack = []}).

init() ->
    #state{}.

next(Price) ->
    State = get_state(),
    {Count, NewStack} = calculate_span(Price, State#state.stack, 1),
    put_state(State#state{stack = NewStack}),
    Count.

calculate_span(Price, [{P, C} | Rest], Count) when Price >= P ->
    calculate_span(Price, Rest, Count + C);
calculate_span(Price, Stack, Count) ->
    {Count, [{Price, Count} | Stack]}.

get_state() ->
    case get(stock_spanner_state) of
        undefined -> init();
        State -> State
    end.

put_state(State) ->
    put(stock_spanner_state, State).