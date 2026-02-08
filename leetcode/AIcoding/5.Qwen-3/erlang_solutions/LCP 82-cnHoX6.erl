-module(solution).
-export([is_subtree/2]).

is_subtree(Node1, Node2) ->
    is_subtree(Node1, Node2, false).

is_subtree(_, _, true) ->
    true;
is_subtree(null, null, _) ->
    true;
is_subtree(null, _, _) ->
    false;
is_subtree(_, null, _) ->
    false;
is_subtree(Node1, Node2, _) ->
    if
        is_same_tree(Node1, Node2) ->
            true;
        true ->
            is_subtree(left(Node1), Node2, false) orelse is_subtree(right(Node1), Node2, false)
    end.

is_same_tree(null, null) ->
    true;
is_same_tree(null, _) ->
    false;
is_same_tree(_, null) ->
    false;
is_same_tree(Node1, Node2) ->
    value(Node1) == value(Node2) andalso is_same_tree(left(Node1), left(Node2)) andalso is_same_tree(right(Node1), right(Node2)).

value({value, V, _, _}) ->
    V;
left({_, _, L, _}) ->
    L;
right({_, _, _, R}) ->
    R.