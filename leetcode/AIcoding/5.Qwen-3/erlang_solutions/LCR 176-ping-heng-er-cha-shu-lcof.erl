-module(solution).
-export([is_balanced/1]).

is_balanced(nil) -> true;
is_balanced(Node) ->
    {Height, Balanced} = dfs(Node),
    Balanced.

dfs(nil) -> {0, true};
dfs({Val, Left, Right}) ->
    {LeftHeight, LeftBalanced} = dfs(Left),
    {RightHeight, RightBalanced} = dfs(Right),
    if
        LeftBalanced == false orelse RightBalanced == false -> {0, false};
        abs(LeftHeight - RightHeight) > 1 -> {0, false};
        true -> {max(LeftHeight, RightHeight) + 1, true}
    end.