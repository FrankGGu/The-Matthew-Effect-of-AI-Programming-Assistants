-module(solution).
-export([find_elements/2]).

-record(node, {val, left = none, right = none}).

find_elements(Tree, Value) ->
    case is_contaminated(Tree) of
        true -> false;
        false -> find_in_tree(Tree, Value)
    end.

is_contaminated(none) -> false;
is_contaminated(#node{val=Val, left=Left, right=Right}) ->
    (Val == -1) orelse is_contaminated(Left) orelse is_contaminated(Right).

find_in_tree(none, _) -> false;
find_in_tree(#node{val=Val, left=Left, right=Right}, Value) ->
    Val == Value orelse find_in_tree(Left, Value) orelse find_in_tree(Right, Value).