-module(skiplist).
-export([new/0, add/2, search/2, erase/2]).

-define(MAX_LEVEL_CAP, 16). % Maximum number of levels a node can have
-define(P, 0.5).             % Probability for increasing level
-define(HEAD_VAL, -1).       % Sentinel value for the head node
-define(HEAD_IDX, 0).        % Index of the head node in the array
-define(NULL_IDX, -1).       % Sentinel for a null next pointer

-record(skiplist_node, {val, nexts}). % val: integer, nexts: array:array() of indices

new() ->
    rand:seed(exs1024, {erlang:monotonic_time(nanosecond), self(), make_ref()}),
    HeadNode = #skiplist_node{val = ?HEAD_VAL, nexts = array:new(?MAX_LEVEL_CAP, {default, ?NULL_IDX})},
    NodesArray = array:new(),
    NodesArray1 = array:set(?HEAD_IDX, HeadNode, NodesArray),
    {1, ?HEAD_IDX, ?HEAD_IDX + 1, NodesArray1}.

add(Val, {CurrentMaxLevel, HeadIdx, NextAvailableIdx, NodesArray}) ->
    UpdateIndicesArray = find_update_path(CurrentMaxLevel - 1, HeadIdx, NodesArray, Val, array:new(?MAX_LEVEL_CAP)),

    NewNodeLevel = random_level(1, rand:uniform()),
    NewCurrentMaxLevel = max(CurrentMaxLevel, NewNodeLevel),

    NewNodeNextsArray = array:new(?MAX_LEVEL_CAP, {default, ?NULL_IDX}),
    NewNodeNextsArray1 = populate_new_node_nexts(0, NewNodeLevel, NewNodeNextsArray, UpdateIndicesArray, NodesArray),
    NewNode = #skiplist_node{val = Val, nexts = NewNodeNextsArray1},

    NodesArray1 = array:set(NextAvailableIdx, NewNode, NodesArray),
    NodesArray2 = update_pointers_to_new_node(0, NewNodeLevel, NextAvailableIdx, NodesArray1, UpdateIndicesArray),

    {NewCurrentMaxLevel, HeadIdx, NextAvailableIdx + 1, NodesArray2}.

search(Val, {CurrentMaxLevel, HeadIdx, _NextAvailableIdx, NodesArray}) ->
    {SearchIdx, _} = find_search_path(CurrentMaxLevel - 1, HeadIdx, NodesArray, Val),

    CurrentNode = array:get(SearchIdx, NodesArray),
    NextIdxAtLevel0 = array:get(0, CurrentNode#skiplist_node.nexts),

    case NextIdxAtLevel0 =/= ?NULL_IDX of
        true ->
            NextNodeAtLevel0 = array:get(NextIdxAtLevel0, NodesArray),
            NextNodeAtLevel0#skiplist_node.val == Val;
        false ->
            false
    end.

erase(Val, {CurrentMaxLevel, HeadIdx, NextAvailableIdx, NodesArray}) ->
    UpdateIndicesArray = find_update_path(CurrentMaxLevel - 1, HeadIdx, NodesArray, Val, array:new(?MAX_LEVEL_CAP)),

    UpdateNodeAtLevel0Idx = array:get(0, UpdateIndicesArray),
    UpdateNodeAtLevel0 = array:get(UpdateNodeAtLevel0Idx, NodesArray),
    NodeToDeleteIdx = array:get(0, UpdateNodeAtLevel0#skiplist_node.nexts),

    case NodeToDeleteIdx =/= ?NULL_IDX andalso (array:get(NodeToDeleteIdx, NodesArray))#skiplist_node.val == Val of
        true ->
            NodeToDelete = array:get(NodeToDeleteIdx, NodesArray),
            NodesArray1 = update_pointers_to_bypass_deleted_node(0, CurrentMaxLevel, NodeToDeleteIdx, NodeToDelete, NodesArray, UpdateIndicesArray),

            NewCurrentMaxLevel = adjust_max_level(CurrentMaxLevel, HeadIdx, NodesArray1),
            {NewCurrentMaxLevel, HeadIdx, NextAvailableIdx, NodesArray1};
        false ->
            {CurrentMaxLevel, HeadIdx, NextAvailableIdx, NodesArray}
    end.

random_level(Level, R) when R < ?P, Level < ?MAX_LEVEL_CAP ->
    random_level(Level + 1, rand:uniform());
random_level(Level, _R) ->
    Level.

find_update_path(Level, CurrentSearchIdx, NodesArray, Val, UpdateIndicesArray) when Level >= 0 ->
    CurrentNode = array:get(CurrentSearchIdx, NodesArray),
    NextIdxAtLevel = array:get(Level, CurrentNode#skiplist_node.nexts),
    {NewCurrentSearchIdx, _} = skip_forward(NextIdxAtLevel, CurrentSearchIdx, Level, NodesArray, Val),
    NewUpdateIndicesArray = array:set(Level, NewCurrentSearchIdx, UpdateIndicesArray),
    find_update_path(Level - 1, NewCurrentSearchIdx, NodesArray, Val, NewUpdateIndicesArray);
find_update_path(_, _, _, _, UpdateIndicesArray) ->
    UpdateIndicesArray.

find_search_path(Level, CurrentSearchIdx, NodesArray, Val) when Level >= 0 ->
    CurrentNode = array:get(CurrentSearchIdx, NodesArray),
    NextIdxAtLevel = array:get(Level, CurrentNode#skiplist_node.nexts),
    {NewCurrentSearchIdx, _} = skip_forward(NextIdxAtLevel, CurrentSearchIdx, Level, NodesArray, Val),
    find_search_path(Level - 1, NewCurrentSearchIdx, NodesArray, Val);
find_search_path(_, CurrentSearchIdx, _, _) ->
    {CurrentSearchIdx, ?NULL_IDX}. % The second element is not used for search path, but for consistency with skip_forward

skip_forward(NextIdx, CurrentIdx, Level, NodesArray, Val) ->
    case NextIdx =/= ?NULL_IDX of
        true ->
            NextNode = array:get(NextIdx, NodesArray),
            case NextNode#skiplist_node.val < Val of
                true ->
                    skip_forward(array:get(Level, NextNode#skiplist_node.nexts), NextIdx, Level, NodesArray, Val);
                false ->
                    {CurrentIdx, NextIdx}
            end;
        false ->
            {CurrentIdx, NextIdx}
    end.

populate_new_node_nexts(I, NewNodeLevel, NewNodeNextsArray, UpdateIndicesArray, NodesArray) when I < NewNodeLevel ->
    UpdateNodeIdx = array:get(I, UpdateIndicesArray),
    UpdateNode = array:get(UpdateNodeIdx, NodesArray),
    OldNextIdx = array:get(I, UpdateNode#skiplist_node.nexts),
    NewNodeNextsArray1 = array:set(I, OldNextIdx, NewNodeNextsArray),
    populate_new_node_nexts(I + 1, NewNodeLevel, NewNodeNextsArray1, UpdateIndicesArray, NodesArray);
populate_new_node_nexts(_, _, NewNodeNextsArray, _, _) ->
    NewNodeNextsArray.

update_pointers_to_new_node(I, NewNodeLevel, NewNodeIdx, NodesArray, UpdateIndicesArray) when I < NewNodeLevel ->
    UpdateNodeIdx = array:get(I, UpdateIndicesArray),
    UpdateNode = array:get(UpdateNodeIdx, NodesArray),
    NewUpdateNodeNexts = array:set(I, NewNodeIdx, UpdateNode#skiplist_node.nexts),
    NewUpdateNode = UpdateNode#skiplist_node{nexts = NewUpdateNodeNexts},
    NodesArray1 = array:set(UpdateNodeIdx, NewUpdateNode, NodesArray),
    update_pointers_to_new_node(I + 1, NewNodeLevel, NewNodeIdx, NodesArray1, UpdateIndicesArray);
update_pointers_to_new_node(_, _, _, NodesArray, _) ->
    NodesArray.

update_pointers_to_bypass_deleted_node(I, CurrentMaxLevel, NodeToDeleteIdx, NodeToDelete, NodesArray, UpdateIndicesArray) when I < CurrentMaxLevel ->
    UpdateNodeIdx = array:get(I, UpdateIndicesArray),
    UpdateNode = array:get(UpdateNodeIdx, NodesArray),
    NextIdxOfUpdateNode = array:get(I, UpdateNode#skiplist_node.nexts),
    NodesArray1 = case NextIdxOfUpdateNode == NodeToDeleteIdx of
        true ->
            NextNextIdx = array:get(I, NodeToDelete#skiplist_node.nexts),
            NewUpdateNodeNexts = array:set(I, NextNextIdx, UpdateNode#skiplist_node.nexts),
            NewUpdateNode = UpdateNode#skiplist_node{nexts = NewUpdateNodeNexts},
            array:set(UpdateNodeIdx, NewUpdateNode, NodesArray);
        false ->
            NodesArray
    end,
    update_pointers_to_bypass_deleted_node(I + 1, CurrentMaxLevel, NodeToDeleteIdx, NodeToDelete, NodesArray1, UpdateIndicesArray);
update_pointers_to_bypass_deleted_node(_, _, _, _, NodesArray, _) ->
    NodesArray.

adjust_max_level(CurrentMaxLevel, HeadIdx, NodesArray) ->
    HeadNode = array:get(HeadIdx, NodesArray),
    adjust_max_level_recursive(CurrentMaxLevel, HeadNode).

adjust_max_level_recursive(Level, HeadNode) when Level > 1 ->
    case array:get(Level - 1, HeadNode#skiplist_node.nexts) == ?NULL_IDX of
        true ->
            adjust_max_level_recursive(Level - 1, HeadNode);
        false ->
            Level
    end;
adjust_max_level_recursive(Level, _HeadNode) ->
    Level.