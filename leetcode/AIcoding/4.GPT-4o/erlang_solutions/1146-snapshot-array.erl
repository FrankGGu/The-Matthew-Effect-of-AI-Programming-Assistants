-module(snapshot_array).

-export([new/1, set/3, snap/1, get/2]).

-record(snapshot_array, {data, snaps, snap_id}).

new(N) ->
    #snapshot_array{data = lists:duplicate(N, 0), snaps = [], snap_id = 0}.

set(SnapArray, index, val) ->
    SnapArray#snapshot_array{data = lists:replace_element(index + 1, val, SnapArray#snapshot_array.data)}.

snap(SnapArray) ->
    SnapArray#snapshot_array{snaps = [SnapArray#snapshot_array.data | SnapArray#snapshot_array.snaps], snap_id = SnapArray#snapshot_array.snap_id + 1}.

get(SnapArray, index, snap_id) ->
    case lists:nth(snap_id, SnapArray#snapshot_array.snaps) of
        undefined -> lists:nth(index + 1, SnapArray#snapshot_array.data);
        SnapData -> lists:nth(index + 1, SnapData)
    end.