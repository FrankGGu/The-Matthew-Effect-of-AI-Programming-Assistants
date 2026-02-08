-record(tree_node, {val = 0, left = null, right = null}).

-spec all_possible_fbt(N :: integer()) -> [#tree_node{}].
all_possible_fbt(N) when N rem 2 =:= 0 -> [];
all_possible_fbt(1) -> [#tree_node{val = 0, left = null, right = null}];
all_possible_fbt(N) ->
    Result = [],
    lists:foldl(
        fun(I, Acc) ->
            LeftTrees = all_possible_fbt(I),
            RightTrees = all_possible_fbt(N - 1 - I),
            lists:foldl(
                fun(Left, Acc1) ->
                    lists:foldl(
                        fun(Right, Acc2) ->
                            [#tree_node{val = 0, left = Left, right = Right} | Acc2]
                        end,
                        Acc1,
                        RightTrees
                    )
                end,
                Acc,
                LeftTrees
            )
        end,
        Result,
        lists:seq(1, N - 2, 2)
    ).