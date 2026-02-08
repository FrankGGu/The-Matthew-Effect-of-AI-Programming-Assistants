-module(subtree_of_another_tree).
-export([is_subtree/2]).

is_subtree(Root, SubRoot) ->
  is_same_tree(Root, SubRoot) orelse (Root =/= null andalso (is_subtree(get_left(Root), SubRoot) orelse is_subtree(get_right(Root), SubRoot))).

is_same_tree(null, null) -> true;
is_same_tree(null, _) -> false;
is_same_tree(_, null) -> false;
is_same_tree(Root, SubRoot) ->
  get_val(Root) =:= get_val(SubRoot) andalso is_same_tree(get_left(Root), get_left(SubRoot)) andalso is_same_tree(get_right(Root), get_right(SubRoot)).

get_val(null) -> null;
get_val({Val, _, _}) -> Val.

get_left(null) -> null;
get_left({_, Left, _}) -> Left.

get_right(null) -> null;
get_right({_, _, Right}) -> Right.