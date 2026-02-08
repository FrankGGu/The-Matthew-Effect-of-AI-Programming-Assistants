-module(longest_uploaded_prefix).
-export([upload/1, longest/0]).

-record(state, {prefix = 0}).

upload(Ids) ->
    State = erlang:get({?MODULE, state}),
    NewState = update_state(State, Ids),
    erlang:put({?MODULE, state}, NewState),
    ok.

longest() ->
    State = erlang:get({?MODULE, state}),
    State#state.prefix.

update_state(State, []) ->
    State;
update_state(State, [Id | Rest]) ->
    if
        Id == State#state.prefix + 1 ->
            NewState = State#state{prefix = Id},
            update_state(NewState, Rest);
        true ->
            State
    end.