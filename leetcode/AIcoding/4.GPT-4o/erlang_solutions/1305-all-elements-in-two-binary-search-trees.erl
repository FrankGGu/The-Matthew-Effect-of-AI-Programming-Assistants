-module(solution).
-export([getAllElements/2]).

-record(node, {val, left = null, right = null}).

getAllElements(Tree1, Tree2) ->
    Lists1 = tree_to_list(Tree1, []),
    Lists2 = tree_to_list(Tree2, []),
    lists:sort(lists:append(Lists1, Lists2)).

tree_to_list(null, Acc) -> 
    Acc;
tree_to_list(#node{val=Val, left=Left, right=Right}, Acc) ->
    tree_to_list(Left, [Val | tree_to_list(Right, Acc)]).