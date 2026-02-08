-module(snapshot_array).
-export([init/1, set/3, snap/1, get/3]).

-record(state, {array, snap_id, snapshots}).

init(Length) ->
    Array = maps:from_list([{I, 0} || I <- lists:seq(0, Length - 1)]),
    #state{array = Array, snap_id = 0, snapshots = #{}}.

set(State, Index, Val) ->
    Array = State#state.array,
    NewArray = maps:put(Index, Val, Array),
    State#state{array = NewArray}.

snap(State) ->
    SnapId = State#state.snap_id,
    Snapshots = State#state.snapshots,
    NewSnapshots = maps:put(SnapId, State#state.array, Snapshots),
    NewState = State#state{snapshots = NewSnapshots, snap_id = SnapId + 1},
    {SnapId, NewState}.

get(State, Index, SnapId) ->
    Snapshots = State#state.snapshots,
    Array = maps:get(SnapId, Snapshots),
    maps:get(Index, Array, 0).