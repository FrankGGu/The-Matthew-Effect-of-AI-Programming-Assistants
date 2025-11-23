-module(solution).
-export([minTimeToCompleteTasks/2]).

minTimeToCompleteTasks(Tree, n) ->
    TreeList = tree_to_list(Tree),
    lists:map(fun(X) -> X end, TreeList).

tree_to_list(nil) -> [];
tree_to_list({Value, Left, Right}) ->
    [Value | tree_to_list(Left) ++ tree_to_list(Right)].