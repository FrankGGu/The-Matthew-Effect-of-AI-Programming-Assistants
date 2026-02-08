-module(rle_iterator).
-export([new/1, next/1, hasNext/1]).

-record(state, {encoding = [], current_count = 0, current_value}).

new(Encoding) ->
    case Encoding of
        [] ->
            #state{};
        [Count, Value | Rest] ->
            #state{encoding = Rest, current_count = Count, current_value = Value};
        _ ->
            #state{}
    end.

next(State) ->
    case State#state.current_count of
        0 ->
            case State#state.encoding of
                [] ->
                    {-1, State#state{}};
                [Count, Value | Rest] ->
                    NewState = State#state{encoding = Rest, current_count = Count, current_value = Value},
                    {Value, NewState};
                _ ->
                    {-1, State#state{}}
            end;
        _ ->
            NewCount = State#state.current_count - 1,
            NewState = State#state{current_count = NewCount},
            {State#state.current_value, NewState}
    end.

hasNext(State) ->
    case State#state.current_count of
        0 ->
            case State#state.encoding of
                [] ->
                    false;
                _ ->
                    true
            end;
        _ ->
            true
    end.