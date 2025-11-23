-module(solution).
-export([findRedundantDirectedConnection/1]).

findRedundantDirectedConnection(Edges) ->
    N = length(Edges),
    % First pass to identify potential in-degree 2 conflicts
    % Acc: {InDegreeMap, FirstParentForNodeMap, Candidate1Edge, Candidate2Edge}
    {_InDegree, FirstParentForNode, Candidate1, Candidate2} =
        lists:foldl(
            fun([U, V], {AccInDegree, AccFirstParent, C1, C2}) ->
                CurrentInDegree = maps:get(V, AccInDegree, 0) + 1,
                NewInDegree = maps:put(V, CurrentInDegree, AccInDegree),
                {NewC1, NewC2} =
                    if CurrentInDegree == 2 ->
                        {[maps:get(V, AccFirstParent), V], [U, V]}; % C1 is the first edge, C2 is the current edge
                    true ->
                        {C1, C2}
                    end,
                NewFirstParent = maps:put(V, U, AccFirstParent), % Store the first parent for V
                {NewInDegree, NewFirstParent, NewC1, NewC2}
            end,
            {#{}, #{}, none, none}, % Initial accumulator
            Edges
        ),

    if Candidate1 /= none ->
        % Case 1: A node has an in-degree of 2. Candidate1 and Candidate2 are the two edges pointing to it.
        % We need to determine which of these two is the redundant edge.
        % Try removing Candidate2 (the later occurring edge) and check if the remaining graph has a cycle.
        {DsuParents, DsuRanks} = init_dsu(N),

        % Fold over edges, excluding Candidate2, to detect if a cycle still exists.
        % Acc: {CycleEdgeFound, CurrentDsuParents, CurrentDsuRanks}
        {CycleEdge, _, _} =
            lists:foldl(
                fun([U, V], {AccCycleEdge, AccDsuParents, AccDsuRanks}) ->
                    if AccCycleEdge /= none ->
                        % A cycle was already found, no need to process further edges for cycle detection
                        {AccCycleEdge, AccDsuParents, AccDsuRanks};
                    [U, V] == Candidate2 ->
                        % Skip Candidate2 as we are testing its removal
                        {AccCycleEdge, AccDsuParents, AccDsuRanks};
                    true ->
                        {RootU, ParentsAfterFindU} = find_pc(U, AccDsuParents),
                        {RootV, ParentsAfterFindV} = find_pc(V, ParentsAfterFindU), % Use updated parents

                        if RootU == RootV ->
                            % Found a cycle. This means Candidate2 was NOT the redundant edge
                            % that resolved the cycle, so Candidate1 must be the redundant edge.
                            {[U, V], ParentsAfterFindV, AccDsuRanks}; % Store the edge that formed the cycle
                        true ->
                            % No cycle, union the sets
                            {NewDsuParents, NewDsuRanks} = union(RootU, RootV, ParentsAfterFindV, AccDsuRanks),
                            {AccCycleEdge, NewDsuParents, NewDsuRanks}
                        end
                    end
                end,
                {none, DsuParents, DsuRanks}, % Initial accumulator
                Edges
            ),

        if CycleEdge == none ->
            % If no cycle was found after removing Candidate2, then Candidate2 was the redundant edge.
            Candidate2;
        true ->
            % If a cycle was still found (CycleEdge is not none), it means Candidate1 was the redundant edge.
            Candidate1
        end;
    true ->
        % Case 2: No node has an in-degree of 2. The redundant edge must form a simple cycle.
        % Iterate through edges and use DSU to find the LAST edge that creates a cycle.
        {DsuParents, DsuRanks} = init_dsu(N),

        % Acc: {LastCycleFormingEdge, CurrentDsuParents, CurrentDsuRanks}
        {ResultEdge, _, _} =
            lists:foldl(
                fun([U, V], {AccResultEdge, AccDsuParents, AccDsuRanks}) ->
                    {RootU, ParentsAfterFindU} = find_pc(U, AccDsuParents),
                    {RootV, ParentsAfterFindV} = find_pc(V, ParentsAfterFindU), % Use updated parents

                    if RootU == RootV ->
                        % This edge completes a cycle. It's a candidate for the redundant one.
                        % Since we need the LAST such edge, we always update AccResultEdge.
                        {[U, V], ParentsAfterFindV, AccDsuRanks};
                    true ->
                        % No cycle, union the sets
                        {NewDsuParents, NewDsuRanks} = union(RootU, RootV, ParentsAfterFindV, AccDsuRanks),
                        {AccResultEdge, NewDsuParents, NewDsuRanks}
                    end
                end,
                {none, DsuParents, DsuRanks}, % Initial accumulator
                Edges
            ),
        ResultEdge
    end.

init_dsu(N) ->
    Parents = maps:from_list([{I, I} || I <- lists:seq(1, N)]),
    Ranks = maps:from_list([{I, 0} || I <- lists:seq(1, N)]),
    {Parents, Ranks}.

find_pc(Node, DsuParents) ->
    Parent = maps:get(Node, DsuParents),
    if Parent == Node ->
        {Node, DsuParents};
    true ->
        {Root, NewDsuParents} = find_pc(Parent, DsuParents),
        {Root, maps:put(Node, Root, NewDsuParents)}
    end.

union(Root1, Root2, DsuParents, DsuRanks) ->
    Rank1 = maps:get(Root1, DsuRanks),
    Rank2 = maps:get(Root2, DsuRanks),

    if Rank1 < Rank2 ->
        {maps:put(Root1, Root2, DsuParents), DsuRanks};
    Rank1 > Rank2 ->
        {maps:put(Root2, Root1, DsuParents), DsuRanks};
    true -> % Ranks are equal
        {maps:put(Root2, Root1, DsuParents), maps:put(Root1, Rank1 + 1, DsuRanks)}
    end.