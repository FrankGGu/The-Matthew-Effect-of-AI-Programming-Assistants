-module(symmetric_tree).
-export([is_symmetric/1]).

-spec is_symmetric(TreeNode()) -> boolean().
is_symmetric(Root) ->
  is_mirror(Root, Root).

-spec is_mirror(TreeNode(), TreeNode()) -> boolean().
is_mirror(null, null) ->
  true;
is_mirror(null, _) ->
  false;
is_mirror(_, null) ->
  false;
is_mirror({Val1, Left1, Right1}, {Val2, Left2, Right2}) ->
  Val1 == Val2 andalso is_mirror(Left1, Right2) andalso is_mirror(Right1, Left2).