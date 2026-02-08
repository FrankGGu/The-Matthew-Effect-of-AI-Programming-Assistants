-module(check_completeness).
-export([is_complete_tree/1]).

is_complete_tree(Root) ->
    is_complete_tree_helper(Root, 0, tree_size(Root)).

is_complete_tree_helper(null, _, _) ->
    true;
is_complete_tree_helper(Node, Index, Size) ->
    Index < Size andalso
    is_complete_tree_helper(get_left(Node), 2 * Index + 1, Size) andalso
    is_complete_tree_helper(get_right(Node), 2 * Index + 2, Size).

tree_size(null) ->
    0;
tree_size(Node) ->
    1 + tree_size(get_left(Node)) + tree_size(get_right(Node)).

get_left(null) ->
    null;
get_left({Val, L, _}) ->
    L.

get_right(null) ->
    null;
get_right({Val, _, R}) ->
    R.