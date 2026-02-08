-module(solution).
-export([width_of_binary_tree/1]).

-record(node, {val, left = null, right = null}).

width_of_binary_tree(Root) ->
    case Root of
        null -> 0;
        _ -> 
            {MaxWidth, _} = bfs([{Root, 0}], 0, 0),
            MaxWidth
    end.

bfs([], MaxWidth, _) -> {MaxWidth, 0};
bfs(Level, MaxWidth, Depth) ->
    {Count, FirstIndex} = length(Level), 
    if Count == 0 -> {MaxWidth, Depth};
    true -> 
        LastIndex = lists:last(Level),
        CurrentWidth = element(2, LastIndex) - FirstIndex + 1,
        NewMaxWidth = max(CurrentWidth, MaxWidth),
        NewLevel = lists:flatmap(fun({Node, Index}) ->
            case Node of
                null -> [];
                _ -> [{Node#node.left, Index * 2}, {Node#node.right, Index * 2 + 1}]
            end
        end, Level),
        bfs(NewLevel, NewMaxWidth, Depth + 1)
    end.