-module(solution).
-export([number_of_ways_to_reconstruct_a_tree/1]).

number_of_ways_to_reconstruct_a_tree(Pairs) ->
    % 1. Build NodeSets and AllNodes
    {NodeSets, AllNodes} = lists:foldl(
        fun([U, V], {AccNodeSets, AccAllNodes}) ->
            NewAccNodeSets1 = maps:update_with(U, fun(S) -> gb_sets:add_element(V, S) end, gb_sets:from_list([V]), AccNodeSets),
            NewAccNodeSets2 = maps:update_with(V, fun(S) -> gb_sets:add_element(U, S) end, gb_sets:from_list([U]), NewAccNodeSets1),
            NewAccAllNodes1 = gb_sets:add_element(U, AccAllNodes),
            NewAccAllNodes2 = gb_sets:add_element(V, NewAccAllNodes1),
            {NewAccNodeSets2, NewAccAllNodes2}
        end,
        {#{}, gb_sets:new()},
        Pairs
    ),

    FinalNodeSets = lists:foldl(
        fun(Node, AccNodeSets) ->
            maps:update_with(Node, fun(S) -> gb_sets:add_element(Node, S) end, gb_sets:from_list([Node]), AccNodeSets)
        end,
        NodeSets,
        gb_sets:to_list(AllNodes)
    ),

    % 2. Sort nodes by PathSet size (descending)
    SortedNodesWithSets = lists:sort(
        fun({_N1, S1}, {_N2, S2}) -> gb_sets:size(S1) >= gb_sets:size(S2) end,
        maps:to_list(FinalNodeSets)
    ),

    % 3. Verify root and count ways
    case SortedNodesWithSets of
        [] -> 0;
        [{_Root, RootPathSet} | _] ->
            if gb_sets:size(RootPathSet) /= gb_sets:size(AllNodes) ->
                0;
            true ->
                do_check_nodes(SortedNodesWithSets, 2, FinalNodeSets, 1)
            end
    end.

do_check_nodes(SortedNodesWithSets, Index, NodeSets, CurrentWays) ->
    if Index > length(SortedNodesWithSets) ->
        CurrentWays;
    true ->
        {U, PathSet_U} = lists:nth(Index, SortedNodesWithSets),

        PotentialAncestorsWithSets = lists:sublist(SortedNodesWithSets, Index - 1),
        {FoundParent, ActualParent, ActualParentPathSet} = find_actual_parent(
            PathSet_U, PotentialAncestorsWithSets
        ),

        if not FoundParent ->
            0;
        true ->
            % Consistency check: For every X in ActualParentPathSet \ PathSet_U, PathSet_U must be a subset of PathSet_X
            ConsistencyCheck = lists:all(
                fun(X) ->
                    PathSet_X = maps:get(X, NodeSets),
                    gb_sets:is_subset(PathSet_U, PathSet_X)
                end,
                gb_sets:to_list(gb_sets:difference(ActualParentPathSet, PathSet_U))
            ),

            if not ConsistencyCheck ->
                0;
            true ->
                NewWays = if gb_sets:size(PathSet_U) == gb_sets:size(ActualParentPathSet) ->
                              2;
                          true ->
                              CurrentWays
                          end,
                do_check_nodes(SortedNodesWithSets, Index + 1, NodeSets, NewWays)
            end
        end
    end.

find_actual_parent(PathSet_U, PotentialAncestorsWithSets) ->
    lists:foldl(
        fun({P, PathSet_P}, {FoundParent, AccActualParent, AccActualParentPathSet}) ->
            if gb_sets:is_subset(PathSet_U, PathSet_P) ->
                if not FoundParent or gb_sets:size(PathSet_P) < gb_sets:size(AccActualParentPathSet) ->
                    {true, P, PathSet_P};
                true ->
                    {FoundParent, AccActualParent, AccActualParentPathSet}
                end;
            true ->
                {FoundParent, AccActualParent, AccActualParentPathSet}
            end
        end,
        {false, -1, gb_sets:new()},
        PotentialAncestorsWithSets
    ).