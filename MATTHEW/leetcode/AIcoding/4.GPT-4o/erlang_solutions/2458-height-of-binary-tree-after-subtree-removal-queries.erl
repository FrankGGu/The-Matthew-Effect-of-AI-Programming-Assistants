-module(solution).
-export([tree_queries/2]).

tree_queries(Tree, Queries) ->
    {Height, Nodes} = calculate_height(Tree, 0, []),
    lists:map(fun(Query) -> calculate_new_height(Nodes, Query) end, Queries).

calculate_height(nil, Height, Nodes) ->
    {Height, Nodes};
calculate_height({Value, Left, Right}, Height, Nodes) ->
    {LeftHeight, LeftNodes} = calculate_height(Left, Height + 1, [Value | Nodes]),
    {RightHeight, RightNodes} = calculate_height(Right, Height + 1, LeftNodes),
    MaxHeight = max(LeftHeight, RightHeight),
    {MaxHeight, RightNodes}.

calculate_new_height(Nodes, Query) ->
    NewHeight = find_new_height(Nodes, Query),
    if
        NewHeight < 0 -> 0;
        true -> NewHeight
    end.

find_new_height(Nodes, Query) ->
    case lists:member(Query, Nodes) of
        true -> -1;
        false -> 0
    end.