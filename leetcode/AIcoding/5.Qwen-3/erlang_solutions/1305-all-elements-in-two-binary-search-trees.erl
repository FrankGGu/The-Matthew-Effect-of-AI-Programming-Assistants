-module(solution).
-export([all_elements/1]).

all_elements(Tree) ->
    flatten_tree(Tree, []).

flatten_tree(nil, Acc) ->
    lists:reverse(Acc);
flatten_tree({Val, Left, Right}, Acc) ->
    flatten_tree(Left, [Val | flatten_tree(Right, Acc)]).

all_elements(Trees) ->
    lists:usort(lists:flatten([all_elements(Tree) || Tree <- Trees])).