-module(peeking_iterator).
-export([new/1, peek/1, next/1, has_next/1]).

-record(iterator_state, {
    list :: list()
}).

iterator_new(List) ->
    #iterator_state{list = List}.

iterator_next(#iterator_state{list = []}) ->
    eof;
iterator_next(#iterator_state{list = [H|T]}) ->
    {H, #iterator_state{list = T}}.

iterator_has_next(#iterator_state{list = []}) ->
    false;
iterator_has_next(#iterator_state{list = [_|_]}) ->
    true.

-record(pi_state, {
    current_iterator_state, % The underlying iterator's state (#iterator_state{} record)
    has_peeked = false,     % True if a value has been peeked and stored
    peeked_value = undefined % The value that was peeked
}).

new(IteratorState) ->
    #pi_state{current_iterator_state = IteratorState}.

peek(PIState = #pi_state{has_peeked = true, peeked_value = Value}) ->
    {ok, Value, PIState};
peek(PIState = #pi_state{has_peeked = false, current_iterator_state = CurrentIteratorState}) ->
    case iterator_has_next(CurrentIteratorState) of
        true ->
            {Value, NewIteratorState} = iterator_next(CurrentIteratorState),
            NewPIState = PIState#pi_state{has_peeked = true, peeked_value = Value, current_iterator_state = NewIteratorState},
            {ok, Value, NewPIState};
        false ->
            {error, no_more_elements, PIState}
    end.

next(PIState = #pi_state{has_peeked = true, peeked_value = Value}) ->
    %% We have a peeked value, so consume it and reset has_peeked.
    %% The underlying iterator has already been advanced when the value was peeked.
    NewPIState = PIState#pi_state{has_peeked = false, peeked_value = undefined},
    {ok, Value, NewPIState};
next(PIState = #pi_state{has_peeked = false, current_iterator_state = CurrentIteratorState}) ->
    case iterator_has_next(CurrentIteratorState) of
        true ->
            {Value, NewIteratorState} = iterator_next(CurrentIteratorState),
            NewPIState = PIState#pi_state{current_iterator_state = NewIteratorState}, % Only advance underlying iterator
            {ok, Value, NewPIState};
        false ->
            {error, no_more_elements, PIState}
    end.

has_next(PIState = #pi_state{has_peeked = true}) ->
    %% If we have a peeked value, then there is definitely a next element
    {true, PIState};
has_next(PIState = #pi_state{has_peeked = false, current_iterator_state = CurrentIteratorState}) ->
    case iterator_has_next(CurrentIteratorState) of
        true -> {true, PIState};
        false -> {false, PIState}
    end.