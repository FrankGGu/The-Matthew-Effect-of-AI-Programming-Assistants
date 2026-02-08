-module(snapshot_array).
-export([init/1, set/3, snap/1, get/3]).

-record(state, {
    current_snap_id :: integer(),
    array_data :: map() % map of index -> gb_tree() of snap_id -> value
}).

init(_Length) ->
    {ok, #state{current_snap_id = 0, array_data = #{}}}.

set(#state{current_snap_id = CurrentSnapId, array_data = ArrayData} = State, Index, Val) ->
    HistoryTree = maps:get(Index, ArrayData, gb_trees:empty()),
    NewHistoryTree = gb_trees:insert(CurrentSnapId, Val, HistoryTree),
    NewArrayData = maps:put(Index, NewHistoryTree, ArrayData),
    {ok, State#state{array_data = NewArrayData}}.

snap(#state{current_snap_id = CurrentSnapId} = State) ->
    NewSnapId = CurrentSnapId + 1,
    {ok, CurrentSnapId, State#state{current_snap_id = NewSnapId}}.

get(#state{array_data = ArrayData}, Index, SnapId) ->
    HistoryTree = maps:get(Index, ArrayData, gb_trees:empty()),
    case gb_trees:lookup_le(SnapId, HistoryTree) of
        {value, _, Val} -> Val;
        none -> 0
    end.