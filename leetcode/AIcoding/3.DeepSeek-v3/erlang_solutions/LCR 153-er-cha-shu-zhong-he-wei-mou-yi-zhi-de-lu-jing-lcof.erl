-record(treeNode, {val = 0 :: integer(),
                   left = null  :: 'null' | #treeNode{},
                   right = null :: 'null' | #treeNode{}}).

-spec path_sum(Root :: #treeNode{} | null, TargetSum :: integer()) -> [[integer()]].
path_sum(Root, TargetSum) ->
    case Root of
        null -> [];
        _ -> path_sum_helper(Root, TargetSum, [], [])
    end.

-spec path_sum_helper(Node :: #treeNode{} | null, TargetSum :: integer(), Path :: [integer()], Acc :: [[integer()]]) -> [[integer()]].
path_sum_helper(null, _, _, Acc) -> Acc;
path_sum_helper(#treeNode{val = Val, left = Left, right = Right}, TargetSum, Path, Acc) ->
    NewPath = Path ++ [Val],
    NewTarget = TargetSum - Val,
    case Left =:= null andalso Right =:= null of
        true when NewTarget =:= 0 -> [NewPath | Acc];
        true -> Acc;
        false ->
            Acc1 = path_sum_helper(Left, NewTarget, NewPath, Acc),
            path_sum_helper(Right, NewTarget, NewPath, Acc1)
    end.