-spec find_target(Root :: #tree_node{} | null, K :: integer()) -> boolean().
find_target(Root, K) ->
    Set = sets:new(),
    find_target(Root, K, Set).

find_target(null, _K, _Set) -> false;
find_target(#tree_node{val = Val, left = Left, right = Right}, K, Set) ->
    case sets:is_element(K - Val, Set) of
        true -> true;
        false ->
            NewSet = sets:add_element(Val, Set),
            find_target(Left, K, NewSet) orelse find_target(Right, K, NewSet)
    end.