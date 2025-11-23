-module(snapshot_array).
-export([new/1, set/3, snap/1, get/3]).

-record(snapshot, {data = dict:new(), snap_id = 0}).

new(Length) ->
    {ok, #snapshot{}}.

set(SnapshotArray, Index, Value) ->
    SnapshotArray#snapshot{data = dict:store(Index, Value, SnapshotArray#snapshot.data)}.

snap(SnapshotArray) ->
    Id = SnapshotArray#snapshot.snap_id,
    {ok, SnapshotArray#snapshot{snap_id = Id + 1}, Id}.

get(SnapshotArray, Index, SnapId) ->
    case dict:find(Index, SnapshotArray#snapshot.data) of
        {ok, Value} -> {ok, Value};
        error -> {ok, 0}
    end.