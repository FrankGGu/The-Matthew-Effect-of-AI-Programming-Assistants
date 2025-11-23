-spec longest_zig_zag(Root :: #tree_node{} | null) -> integer().
longest_zig_zag(Root) ->
    case Root of
        null -> 0;
        _ -> 
            {_, _, Max} = dfs(Root, left, 0),
            {_, _, Max2} = dfs(Root, right, 0),
            max(Max, Max2) - 1
    end.

dfs(null, _, CurrentMax) -> {0, 0, CurrentMax};
dfs(Node, Direction, CurrentMax) ->
    {Left1, Right1, Max1} = dfs(Node#tree_node.left, left, CurrentMax),
    {Left2, Right2, Max2} = dfs(Node#tree_node.right, right, CurrentMax),
    case Direction of
        left ->
            Len = Right1 + 1,
            NewMax = max(max(Max1, Max2), max(Len, CurrentMax)),
            {Len, Left2 + 1, NewMax};
        right ->
            Len = Left2 + 1,
            NewMax = max(max(Max1, Max2), max(Len, CurrentMax)),
            {Right1 + 1, Len, NewMax}
    end.