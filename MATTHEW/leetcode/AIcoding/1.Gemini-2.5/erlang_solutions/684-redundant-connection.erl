-module(solution).
-export([find_redundant_connection/1]).

find(Node, Parents) ->
    case gb_trees:is_defined(Node, Parents) of
        false ->
            % Node not seen before, it's its own parent/root
            {Node, gb_trees:insert(Node, Node, Parents)};
        true ->
            Parent = gb_trees:get(Node, Parents),
            if Parent == Node ->
                % Node is its own parent, it's the root
                {Node, Parents};
            true ->
                % Recurse to find the root of the parent
                {Root, UpdatedParents} = find(Parent, Parents),
                % Path compression: make Node point directly to Root
                {Root, gb_trees:update(Node, Root, UpdatedParents)}
            end
    end.

union(Node1, Node2, Parents) ->
    {Root1, Parents1} = find(Node1, Parents),
    {Root2, Parents2} = find(Node2, Parents1), % Use Parents1 for the second find to ensure updates are propagated

    if Root1 == Root2 ->
        % Already in the same set, this edge is redundant
        {true, Parents2};
    true ->
        % Union them: make Root1's parent Root2
        {false, gb_trees:update(Root1, Root2, Parents2)}
    end.

find_redundant_connection(Edges) ->
    InitialParents = gb_trees:empty(),
    find_redundant_connection_recursive(Edges, InitialParents).

find_redundant_connection_recursive([[U, V] | RestEdges], Parents) ->
    case union(U, V, Parents) of
        {true, _UpdatedParents} ->
            % Found the redundant connection
            [U, V];
        {false, NewParents} ->
            % Not redundant, continue with the rest of the edges
            find_redundant_connection_recursive(RestEdges, NewParents)
    end;
find_redundant_connection_recursive([], _Parents) ->
    % This case should ideally not be reached as a redundant connection is guaranteed.
    % Return an empty list or throw an error if this is an invalid state.
    [].