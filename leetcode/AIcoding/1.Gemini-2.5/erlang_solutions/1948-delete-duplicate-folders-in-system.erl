-module(solution).
-export([deleteDuplicateFolders/1]).

deleteDuplicateFolders(Paths) ->
    % 1. Build the file system tree
    RootNode = build_tree(Paths),

    % 2. Perform post-order traversal to serialize subtrees and collect them
    AllSubtreeSerializationsMap = collect_serializations(RootNode),

    % 3. Identify nodes to be deleted based on duplicate serializations
    NodesToDeleteSet = identify_nodes_to_delete(AllSubtreeSerializationsMap),

    % 4. Traverse the tree again to build the result, skipping deleted nodes
    build_result_paths(RootNode, NodesToDeleteSet).

build_tree(Paths) ->
    RootName = "ROOT", % Dummy root name
    RootId = 0,
    RootNode = {RootName, gb_trees:empty(), RootId},
    NextId = 1, % Start IDs for actual folders from 1

    {FinalRootNode, _FinalNextId} =
        lists:foldl(fun(Path, {CurrentRoot, CurrentNextId}) ->
                        add_path_to_tree_recursive(Path, CurrentRoot, CurrentNextId)
                    end, {RootNode, NextId}, Paths),
    FinalRootNode.

add_path_to_tree_recursive([], CurrentNode, NextId) ->
    {CurrentNode, NextId};
add_path_to_tree_recursive([H|T], {Name, Children, Id}, NextId) ->
    case gb_trees:lookup(H, Children) of
        {value, ChildNode} ->
            {UpdatedChild, NewNextId} = add_path_to_tree_recursive(T, ChildNode, NextId),
            UpdatedChildren = gb_trees:update(H, UpdatedChild, Children),
            {{Name, UpdatedChildren, Id}, NewNextId};
        none ->
            NewChildId = NextId,
            NewChildNode = {H, gb_trees:empty(), NewChildId},
            {UpdatedChild, NewNextId} = add_path_to_tree_recursive(T, NewChildNode, NewChildId + 1),
            UpdatedChildren = gb_trees:insert(H, UpdatedChild, Children),
            {{Name, UpdatedChildren, Id}, NewNextId}
    end.

collect_serializations(RootNode) ->
    InitialMap = gb_trees:empty(), % Map: Serialization -> [{NodeId, NodeRef}]
    {_RootSerialization, FinalAllSubtreeSerializationsMap} =
        post_order_serialize(RootNode, InitialMap),
    FinalAllSubtreeSerializationsMap.

post_order_serialize({Name, Children, Id}=Node, AllSubtreeSerializationsMap) ->
    % Children are already sorted by name when retrieved via gb_trees:values
    SortedChildren = gb_trees:values(Children),

    {UpdatedAllSubtreeSerializationsMap, ReversedSerializedChildren} =
        lists:foldl(fun(ChildNode, {AccMap, AccSerials}) ->
                        {ChildSerialization, NewAccMap} =
                            post_order_serialize(ChildNode, AccMap),
                        {NewAccMap, [ChildSerialization | AccSerials]} % Prepend
                    end, {AllSubtreeSerializationsMap, []}, SortedChildren),

    SerializedChildren = lists:reverse(ReversedSerializedChildren), % Reverse once at the end

    CurrentNodeSerialization = {Name, SerializedChildren},

    NewAllSubtreeSerializationsMap =
        case gb_trees:lookup(CurrentNodeSerialization, UpdatedAllSubtreeSerializationsMap) of
            {value, ExistingNodes} ->
                gb_trees:update(CurrentNodeSerialization, ExistingNodes ++ [{Id, Node}], UpdatedAllSubtreeSerializationsMap);
            none ->
                gb_trees:insert(CurrentNodeSerialization, [{Id, Node}], UpdatedAllSubtreeSerializationsMap)
        end,

    {CurrentNodeSerialization, NewAllSubtreeSerializationsMap}.

identify_nodes_to_delete(AllSubtreeSerializationsMap) ->
    NodesToDeleteSet = gb_sets:empty(),
    gb_trees:fold(fun(_Serialization, NodeIdNodeRefs, AccNodesToDeleteSet) ->
                      if length(NodeIdNodeRefs) > 1 ->
                             % Sort by NodeId to find the "first" (smallest ID)
                             SortedNodeIdNodeRefs = lists:sort(fun({Id1, _}, {Id2, _}) -> Id1 < Id2 end, NodeIdNodeRefs),
                             % Keep the first, delete the rest
                             [_First | Rest] = SortedNodeIdNodeRefs,
                             lists:foldl(fun({_Id, Node}, Acc) -> gb_sets:add(Node, Acc) end, AccNodesToDeleteSet, Rest);
                         true -> AccNodesToDeleteSet
                      end
                  end, NodesToDeleteSet, AllSubtreeSerializationsMap).

build_result_paths(RootNode, NodesToDeleteSet) ->
    % The dummy root node itself should not be part of the result,
    % nor should it be deleted.
    {_RootName, RootChildren, _RootId} = RootNode,
    % Children are already sorted by name when retrieved via gb_trees:values
    SortedRootChildren = gb_trees:values(RootChildren),

    ReversedPaths = lists:foldl(fun(ChildNode, AccPaths) ->
                                    collect_paths(ChildNode, [], NodesToDeleteSet, AccPaths)
                                end, [], SortedRootChildren),
    lists:reverse(ReversedPaths).

collect_paths({Name, Children, _Id}=Node, CurrentPathAcc, NodesToDeleteSet, AccPaths) ->
    if gb_sets:is_element(Node, NodesToDeleteSet) ->
           AccPaths; % This node and its children are deleted
       true ->
           % Build path by prepending for efficiency
           NewCurrentPathAcc = [Name | CurrentPathAcc],
           if gb_trees:is_empty(Children) ->
                  [lists:reverse(NewCurrentPathAcc) | AccPaths]; % Prepend reversed path
              true ->
                  % Children are already sorted by name when retrieved via gb_trees:values
                  SortedChildren = gb_trees:values(Children),
                  lists:foldl(fun(ChildNode, Acc) ->
                                  collect_paths(ChildNode, NewCurrentPathAcc, NodesToDeleteSet, Acc)
                              end, AccPaths, SortedChildren)
           end
    end.