-module(solution).
-export([largest_values/1]).

-record('TreeNode', {val, left, right}).

-spec largest_values('TreeNode' | nil) -> [integer()].
largest_values(nil) -> [];
largest_values(Root) ->
    largest_values_bfs([Root], []).

largest_values_bfs([], Acc) ->
    lists:reverse(Acc);
largest_values_bfs(CurrentLevelNodes, Acc) ->
    MaxVal = lists:foldl(fun(#'TreeNode'{val = V}, Max) -> erlang:max(V, Max) end,
                         hd(CurrentLevelNodes)#'TreeNode'.val,
                         tl(CurrentLevelNodes)),
    NextLevelNodes = lists:flatmap(fun(#'TreeNode'{left = L, right = R}) ->
                                       lists:filter(fun(X) -> X /= nil end, [L, R])
                                   end, CurrentLevelNodes),
    largest_values_bfs(NextLevelNodes, [MaxVal | Acc]).