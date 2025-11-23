-module(symmetric_tree).
-export([is_symmetric/1]).

-type tree() :: 'null' | {integer(), tree(), tree()}.

-spec is_symmetric(tree()) -> boolean().
is_symmetric(Tree) ->
    is_symmetric_helper(Tree, Tree).

-spec is_symmetric_helper(tree(), tree()) -> boolean().
is_symmetric_helper('null', 'null') -> true;
is_symmetric_helper('null', _) -> false;
is_symmetric_helper(_, 'null') -> false;
is_symmetric_helper({Val1, Left1, Right1}, {Val2, Left2, Right2}) ->
    Val1 == Val2 andalso
    is_symmetric_helper(Left1, Right2) andalso
    is_symmetric_helper(Right1, Left2).