-spec flip_match_voyage(TreeNode :: term(), Voyage :: [integer()]) -> [integer()].
flip_match_voyage(Root, Voyage) ->
    {Result, _} = traverse(Root, Voyage),
    case Result of
        [-1] -> [-1];
        _ -> Result
    end.

traverse(nil, Voyage) -> {[], Voyage};
traverse({TreeNode, Left, Right}, [H | T]) when TreeNode =:= H ->
    {LeftRes, LeftRem} = traverse(Left, T),
    case LeftRes of
        [-1] ->
            {RightRes, RightRem} = traverse(Right, LeftRem),
            case RightRes of
                [-1] -> {[-1], []};
                _ -> {[TreeNode | RightRes], RightRem}
            end;
        _ -> {LeftRes, LeftRem}
    end;
traverse({TreeNode, Left, Right}, Voyage) ->
    {LeftRes, LeftRem} = traverse(Left, Voyage),
    case LeftRes of
        [-1] ->
            {RightRes, RightRem} = traverse(Right, Voyage),
            case RightRes of
                [-1] -> {[-1], []};
                _ -> {[TreeNode | RightRes], RightRem}
            end;
        _ -> {LeftRes, LeftRem}
    end.