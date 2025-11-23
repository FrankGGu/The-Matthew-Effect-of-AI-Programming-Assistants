-spec transportation_hub(path :: [[integer()]]) -> integer().
transportation_hub(Path) ->
    In = maps:new(),
    Out = maps:new(),
    Nodes = lists:usort(lists:append(Path)),
    {In1, Out1} = lists:foldl(fun([From, To], {I, O}) ->
        I1 = maps:update_with(To, fun(V) -> V + 1 end, 1, I),
        O1 = maps:update_with(From, fun(V) -> V + 1 end, 1, O),
        {I1, O1}
    end, {In, Out}, Path),
    lists:foldl(fun(Node, Acc) ->
        case {maps:get(Node, In1, 0), maps:get(Node, Out1, 0)} of
            {InDegree, 0} when InDegree =:= length(Nodes) - 1 -> Node;
            _ -> Acc
        end
    end, -1, Nodes).