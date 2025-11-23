-module(peeking_iterator).

-export([init/1, next/1, peek/1, has_next/1]).

-record(state, {iterator, peeked}).

init(Iterator) ->
    #state{iterator = Iterator, peeked = none}.

next(State) ->
    case State#state.peeked of
        none ->
            case has_next(State) of
                true ->
                    {Value, NewIterator} = State#state.iterator(),
                    {#state{iterator = NewIterator, peeked = none}, Value};
                false ->
                    erlang:error(badarg)
            end;
        Value ->
            {#state{iterator = State#state.iterator, peeked = none}, Value}
    end.

peek(State) ->
    case State#state.peeked of
        none ->
            case has_next(State) of
                true ->
                    {Value, NewIterator} = State#state.iterator(),
                    {#state{iterator = NewIterator, peeked = Value}, Value};
                false ->
                    erlang:error(badarg)
            end;
        Value ->
            {State, Value}
    end.

has_next(State) ->
    case State#state.peeked of
        none ->
            try
                {_, _} = State#state.iterator()
            catch
                _:_ ->
                    false
            end;
        _ ->
            true
    end.