-module(longest_univalue_path).
-export([longestUnivaluePath/1]).

longestUnivaluePath(Root) ->
    {_, Max} = dfs(Root),
    Max.

dfs(nil) ->
    {0, 0};
dfs(#{} = Node) ->
    Left = maps:get(left, Node),
    Right = maps:get(right, Node),
    Val = maps:get(val, Node),
    {LeftVal, LeftMax} = dfs(Left),
    {RightVal, RightMax} = dfs(Right),
    Current = 0,
    if
        LeftVal == Val ->
            Current = Current + 1;
        true ->
            Current = Current
    end,
    if
        RightVal == Val ->
            Current = Current + 1;
        true ->
            Current = Current
    end,
    Max = lists:max([LeftMax, RightMax, Current]),
    {Val, Max}.