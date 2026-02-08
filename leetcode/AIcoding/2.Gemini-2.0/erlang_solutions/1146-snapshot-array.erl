-module(snapshot_array).
-export([new/1, set/3, get/3, snap/1]).

-record(state, {arr = [], snaps = []}).

new(length) ->
    #state{arr = lists:duplicate(length, 0), snaps = []}.

set(Index, Val, State) ->
    NewArr = lists:replace(Index, Val, State#state.arr),
    State#state{arr = NewArr}.

get(Index, SnapId, State) ->
    case lists:keyfind(SnapId, 1, State#state.snaps) of
        false ->
            0;
        {_, Snapshot} ->
            lists:nth(Index + 1, Snapshot)
    end.

snap(State) ->
    SnapId = length(State#state.snaps),
    NewSnaps = State#state.snaps ++ [{SnapId, State#state.arr}],
    {SnapId, State#state{snaps = NewSnaps}}.