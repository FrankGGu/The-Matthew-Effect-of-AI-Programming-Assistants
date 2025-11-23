-record(treeNode, {val = 0 :: integer(),
                   left = null  :: 'null' | #treeNode{},
                   right = null :: 'null' | #treeNode{}}).

-spec replace_value_in_tree(Root :: #treeNode{} | null) -> #treeNode{} | null.
replace_value_in_tree(Root) ->
    case Root of
        null -> null;
        _ ->
            {LevelSums, _} = traverse(Root, #{}, 0),
            replace(Root, LevelSums, 0, null)
    end.

traverse(null, LevelSums, _Level) -> {LevelSums, null};
traverse(#treeNode{val = Val, left = Left, right = Right}, LevelSums, Level) ->
    NewLevelSums = maps:update_with(Level, fun(Sum) -> Sum + Val end, Val, LevelSums),
    {LevelSums1, Left1} = traverse(Left, NewLevelSums, Level + 1),
    {LevelSums2, Right1} = traverse(Right, LevelSums1, Level + 1),
    {LevelSums2, #treeNode{val = Val, left = Left1, right = Right1}}.

replace(null, _LevelSums, _Level, _Parent) -> null;
replace(Node, LevelSums, Level, Parent) ->
    #treeNode{val = Val, left = Left, right = Right} = Node,
    SiblingSum = case Parent of
        null -> 0;
        #treeNode{left = ParentLeft, right = ParentRight} ->
            if
                ParentLeft =:= Node -> 
                    case ParentRight of
                        null -> 0;
                        #treeNode{val = SiblingVal} -> SiblingVal
                    end;
                true ->
                    case ParentLeft of
                        null -> 0;
                        #treeNode{val = SiblingVal} -> SiblingVal
                    end
            end
    end,
    NewVal = maps:get(Level, LevelSums) - Val - SiblingSum,
    NewLeft = replace(Left, LevelSums, Level + 1, Node),
    NewRight = replace(Right, LevelSums, Level + 1, Node),
    #treeNode{val = NewVal, left = NewLeft, right = NewRight}.