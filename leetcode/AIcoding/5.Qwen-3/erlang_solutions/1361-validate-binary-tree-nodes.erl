-module(validate_binary_tree_nodes).
-export([validate_binary_tree/2]).

validate_binary_tree(Nodes, Edges) ->
    case validate(Nodes, Edges) of
        true -> true;
        false -> false
    end.

validate(Nodes, Edges) ->
    NodeCount = length(Nodes),
    if
        NodeCount == 0 -> true;
        true ->
            Parent = lists:seq(0, NodeCount - 1),
            Visited = sets:new(),
            {Visited1, Root} = dfs(0, Parent, Visited, Edges),
            case sets:size(Visited1) == NodeCount andalso is_valid_root(Root, Edges) of
                true -> true;
                false -> false
            end
    end.

dfs(Node, Parent, Visited, Edges) ->
    case sets:is_element(Node, Visited) of
        true -> {Visited, -1};
        false ->
            Visited1 = sets:add_element(Node, Visited),
            Children = get_children(Node, Edges),
            case Children of
                [] -> {Visited1, Node};
                _ ->
                    {Visited2, Root} = dfs(lists:nth(1, Children), Parent, Visited1, Edges),
                    if
                        Root == -1 -> {Visited2, -1};
                        true ->
                            case Children -- [Root] of
                                [] -> {Visited2, Root};
                                _ -> {Visited2, -1}
                            end
                    end
            end
    end.

get_children(Node, Edges) ->
    lists:filter(fun({A, B}) -> A == Node orelse B == Node end, Edges),
    Children = [],
    lists:foreach(fun({A, B}) ->
        case A == Node of
            true -> Children ++ [B];
            false -> Children ++ [A]
        end
    end, Edges),
    Children.

is_valid_root(-1, _) -> false;
is_valid_root(Root, Edges) ->
    lists:all(fun({A, B}) -> A == Root orelse B == Root end, Edges).