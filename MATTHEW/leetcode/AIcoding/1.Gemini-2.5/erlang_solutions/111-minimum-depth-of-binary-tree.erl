-module(solution).
-export([min_depth/1]).

-type tree_node() :: {integer(), tree_node() | nil, tree_node() | nil}.

-spec min_depth(Root :: tree_node() | nil) -> integer().
min_depth(nil) -> 0;
min_depth({_Val, nil, nil}) -> 1;
min_depth({_Val, Left, nil}) -> 1 + min_depth(Left);
min_depth({_Val, nil, Right}) -> 1 + min_depth(Right);
min_depth({_Val, Left, Right}) ->
    1 + min(min_depth(Left), min_depth(Right)).