-module(number_container).
-export([new/0, change/2, find/1, remove/1]).

-record(state, {idx = 0, value_map = #{}, index_map = #{}}).

new() ->
    spawn(fun() -> loop(#state{}) end).

change(Container, Value) ->
    Container ! {self(), change, Value},
    receive
        Result -> Result
    end.

find(Container, Value) ->
    Container ! {self(), find, Value},
    receive
        Result -> Result
    end.

remove(Container, Index) ->
    Container ! {self(), remove, Index},
    receive
        Result -> Result
    end.

loop(State) ->
    receive
        {From, change, Value} ->
            case maps:get(Value, State#state.value_map, undefined) of
                undefined ->
                    NewIdx = State#state.idx + 1,
                    NewValueMap = maps:put(Value, NewIdx, State#state.value_map),
                    NewIndexMap = maps:put(NewIdx, Value, State#state.index_map),
                    NewState = State#state{idx = NewIdx, value_map = NewValueMap, index_map = NewIndexMap},
                    From ! {ok, NewIdx},
                    loop(NewState);
                Index ->
                    From ! {ok, Index},
                    loop(State)
            end;
        {From, find, Value} ->
            case maps:get(Value, State#state.value_map, undefined) of
                undefined ->
                    From ! {error, not_found},
                    loop(State);
                Index ->
                    From ! {ok, Index},
                    loop(State)
            end;
        {From, remove, Index} ->
            case maps:get(Index, State#state.index_map, undefined) of
                undefined ->
                    From ! {error, not_found},
                    loop(State);
                Value ->
                    NewValueMap = maps:remove(Value, State#state.value_map),
                    NewIndexMap = maps:remove(Index, State#state.index_map),
                    NewState = State#state{value_map = NewValueMap, index_map = NewIndexMap},
                    From ! {ok},
                    loop(NewState)
            end;
        _ ->
            loop(State)
    end.