-spec largest_values(Root :: #tree_node{} | null) -> [integer()].
largest_values(null) -> [];
largest_values(Root) ->
    Queue = queue:in(Root, queue:new()),
    traverse(queue:new(), Queue, -1, []).

traverse(CurrentLevel, NextLevel, CurrentMax, Result) when queue:is_empty(CurrentLevel) ->
    case queue:is_empty(NextLevel) of
        true -> lists:reverse([CurrentMax | Result]);
        false ->
            NewCurrentLevel = NextLevel,
            NewNextLevel = queue:new(),
            traverse(NewCurrentLevel, NewNextLevel, -1, [CurrentMax | Result])
    end;
traverse(CurrentLevel, NextLevel, CurrentMax, Result) ->
    {{value, Node}, Remaining} = queue:out(CurrentLevel),
    NewMax = max(CurrentMax, Node#tree_node.val),
    NewNextLevel = case Node#tree_node.left of
                     null -> NextLevel;
                     Left -> queue:in(Left, NextLevel)
                   end,
    NewNextLevel2 = case Node#tree_node.right of
                      null -> NewNextLevel;
                      Right -> queue:in(Right, NewNextLevel)
                    end,
    traverse(Remaining, NewNextLevel2, NewMax, Result).