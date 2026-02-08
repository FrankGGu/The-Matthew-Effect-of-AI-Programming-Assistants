%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec is_symmetric(Root :: #tree_node{} | null) -> boolean().
is_symmetric(null) -> true;
is_symmetric(#tree_node{left = Left, right = Right}) ->
    is_mirror(Left, Right).

-spec is_mirror(Left :: #tree_node{} | null, Right :: #tree_node{} | null) -> boolean().
is_mirror(null, null) -> true;
is_mirror(null, _) -> false;
is_mirror(_, null) -> false;
is_mirror(#tree_node{val = ValL, left = LeftL, right = RightL},
          #tree_node{val = ValR, left = LeftR, right = RightR}) ->
    ValL =:= ValR andalso
    is_mirror(LeftL, RightR) andalso
    is_mirror(RightL, LeftR).
