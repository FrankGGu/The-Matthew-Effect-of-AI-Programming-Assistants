-module(max_path_sum).
-export([maxPathSum/1]).

-include_lib("eunit/include/eunit.hrl").

-type tree() :: nil | {integer(), tree(), tree()}.

-spec maxPathSum(tree()) -> integer().
maxPathSum(Tree) ->
    {Max, _} = dfs(Tree),
    Max.

dfs(nil) ->
    {0, 0};
dfs({Val, Left, Right}) ->
    {LeftMax, LeftSingle} = dfs(Left),
    {RightMax, RightSingle} = dfs(Right),
    CurrentMax = Val + max(LeftSingle, 0) + max(RightSingle, 0),
    CurrentSingle = Val + max(0, max(LeftSingle, RightSingle)),
    {max(CurrentMax, max(LeftMax, RightMax)), CurrentSingle}.