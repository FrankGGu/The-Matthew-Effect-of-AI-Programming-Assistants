-record('TreeNode', {val, left = nil, right = nil}).

-spec isSymmetric(Root :: #'TreeNode'{} | nil) -> boolean().
isSymmetric(nil) ->
    true;
isSymmetric(#'TreeNode'{left = Left, right = Right}) ->
    is_mirror(Left, Right).

is_mirror(nil, nil) ->
    true;
is_mirror(nil, _) ->
    false;
is_mirror(_, nil) ->
    false;
is_mirror(#'TreeNode'{val = Val1, left = Left1, right = Right1}, #'TreeNode'{val = Val2, left = Left2, right = Right2}) ->
    Val1 == Val2 andalso
    is_mirror(Left1, Right2) andalso
    is_mirror(Right1, Left2).