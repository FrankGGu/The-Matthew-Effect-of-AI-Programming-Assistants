-module(solution).
-export([num_colors/1]).

num_colors(#{<<"root">> := Root}) ->
    dfs(Root, 0).

dfs(null, _) ->
    0;
dfs(#{<<"val">> := Val, <<"left">> := Left, <<"right">> := Right}, Color) ->
    case Val of
        0 -> dfs(Left, 0) + dfs(Right, 0);
        _ -> dfs(Left, Val) + dfs(Right, Val)
    end.