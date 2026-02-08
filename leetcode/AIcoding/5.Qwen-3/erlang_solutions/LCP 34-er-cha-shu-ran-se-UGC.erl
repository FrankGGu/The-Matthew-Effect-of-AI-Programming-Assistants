-module(solution).
-export([dfs/1]).

dfs(Root) ->
    dfs(Root, 0).

dfs(nil, _) ->
    0;
dfs(#{} = Node, Count) ->
    Left = maps:get(left, Node),
    Right = maps:get(right, Node),
    Color = maps:get(color, Node),
    case Color of
        0 ->
            dfs(Left, Count + 1) + dfs(Right, Count + 1);
        _ ->
            dfs(Left, Count) + dfs(Right, Count)
    end.