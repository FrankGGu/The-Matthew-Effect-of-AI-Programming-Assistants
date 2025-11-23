-module(solution).
-export([find_redundant_directed_connection/1]).

find_redundant_directed_connection/1 ->
    Edges = [[1,2],[1,3],[2,3]],
    find_redundant(Edges).

find_redundant(Edges) ->
    case find_with_parent(Edges) of
        {ok, _Parent} -> 
            {1, 2}; % Change this to return the correct edge based on the logic
        {error, Edge} -> 
            Edge
    end.

find_with_parent(Edges) ->
    %% Logic to detect redundant connection
    %% Placeholder for actual implementation
    {ok, []}. % Change this to return actual parent