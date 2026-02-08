-module(solution).
-export([makeConnected/2]).

find(Node, ParentsMap) ->
    case maps:get(Node, ParentsMap, Node) of % If Node is not in map, it's its own parent
        Node -> {Node, ParentsMap}; % Node is a root
        Parent ->
            {Root, UpdatedParentsMap} = find(Parent, ParentsMap),
            {Root, maps:put(Node, Root, UpdatedParentsMap)} % Path compression
    end.

union(Node1, Node2, ParentsMap, NumComponents) ->
    {Root1, ParentsMap1} = find(Node1, ParentsMap),
    {Root2, ParentsMap2} = find(Node2, ParentsMap1),
    if
        Root1 == Root2 -> {ParentsMap2, NumComponents}; % Already in the same component
        true ->
            %% Merge Root2 into Root1 (arbitrary choice, could use union by rank/size)
            {maps:put(Root2, Root1, ParentsMap2), NumComponents - 1}
    end.

makeConnected(N, Connections) ->
    NumConnections = length(Connections),
    if
        NumConnections < N - 1 -> -1; % Not enough cables to connect all computers
        true ->
            %% Initialize DSU: each computer is its own component.
            %% ParentsMap tracks parent pointers. Initially empty, nodes added on first access.
            InitialParentsMap = maps:new(),
            InitialNumComponents = N,

            %% Process all connections to merge components.
            {_FinalParentsMap, FinalNumComponents} = lists:foldl(
                fun([U, V], {CurrentParents, CurrentNumComponents}) ->
                    union(U, V, CurrentParents, CurrentNumComponents)
                end,
                {InitialParentsMap, InitialNumComponents},
                Connections
            ),

            %% The number of operations needed is (number of components - 1).
            %% We already ensured enough cables are available.
            FinalNumComponents - 1
    end.