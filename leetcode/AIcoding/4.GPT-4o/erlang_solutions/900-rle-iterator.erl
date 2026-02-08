-module(rle_iterator).
-export([new/1, next/2]).

-record(state, {buffer, index, count}).

new(Buffer) ->
    #state{buffer = Buffer, index = 0, count = 0}.

next(State, K) ->
    case State#state.count of
        0 ->
            if
                State#index >= length(State#state.buffer) ->
                    {-1, State};
                true ->
                    NewIndex = State#index + 1,
                    NewCount = lists:nth(NewIndex, State#state.buffer),
                    Value = lists:nth(NewIndex + 1, State#state.buffer),
                    NewState = State#state{index = NewIndex + 1, count = NewCount - 1},
                    case K > NewCount of
                        true ->
                            next(NewState, K - NewCount);
                        false ->
                            {Value, State#state{count = NewCount - K}}
                    end
            end;
        _ ->
            if
                K > State#state.count ->
                    {lists:nth(State#index, State#state.buffer), State#state{count = 0}};
                true ->
                    {lists:nth(State#index, State#state.buffer), State#state{count = State#state.count - K}}
            end
    end.