-spec right_side_view(Root :: #tree_node{} | null) -> [integer()].
right_side_view(null) -> [];
right_side_view(Root) ->
    Queue = queue:in(Root, queue:new()),
    right_side_view(queue:new(), Queue, []).

right_side_view(CurrentLevel, NextLevel, Result) ->
    case queue:out(CurrentLevel) of
        {empty, _} ->
            case queue:is_empty(NextLevel) of
                true -> lists:reverse(Result);
                false ->
                    {value, Node} = queue:peek(NextLevel),
                    NewCurrent = NextLevel,
                    NewNext = queue:new(),
                    right_side_view(NewCurrent, NewNext, [Node#tree_node.val | Result])
            end;
        {{value, Node}, RestCurrent} ->
            NewNext = case Node#tree_node.left of
                null -> NextLevel;
                Left -> queue:in(Left, NextLevel)
            end,
            NewNext2 = case Node#tree_node.right of
                null -> NewNext;
                Right -> queue:in(Right, NewNext)
            end,
            right_side_view(RestCurrent, NewNext2, Result)
    end.