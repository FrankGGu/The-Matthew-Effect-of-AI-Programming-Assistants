-spec flip_equiv(Root1 :: tree_node() | null, Root2 :: tree_node() | null) -> boolean().
flip_equiv(null, null) -> true;
flip_equiv(null, _) -> false;
flip_equiv(_, null) -> false;
flip_equiv(Root1, Root2) ->
    #tree_node{val = Val1, left = Left1, right = Right1} = Root1,
    #tree_node{val = Val2, left = Left2, right = Right2} = Root2,
    if
        Val1 =/= Val2 -> false;
        true ->
            (flip_equiv(Left1, Left2) andalso flip_equiv(Right1, Right2)) orelse
            (flip_equiv(Left1, Right2) andalso flip_equiv(Right1, Left2))
    end.