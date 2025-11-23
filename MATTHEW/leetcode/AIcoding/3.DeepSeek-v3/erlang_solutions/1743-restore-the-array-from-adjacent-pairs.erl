-spec restore_array(AdjacentPairs :: [[integer()]]) -> [integer()].
restore_array(AdjacentPairs) ->
    Graph = maps:new(),
    Graph1 = lists:foldl(fun([U, V], Acc) ->
        Acc1 = maps:update_with(U, fun(Neighbors) -> [V | Neighbors] end, [V], Acc),
        maps:update_with(V, fun(Neighbors) -> [U | Neighbors] end, [U], Acc1)
    end, Graph, AdjacentPairs),
    Start = lists:min(maps:keys(Graph1)),
    case maps:get(Start, Graph1) of
        [Next | _] -> build_array(Graph1, Start, Next, [Start]);
        [] -> [Start]
    end.

build_array(Graph, Prev, Current, Acc) ->
    case maps:get(Current, Graph) of
        [Prev, Next] -> build_array(Graph, Current, Next, [Current | Acc]);
        [Next, Prev] -> build_array(Graph, Current, Next, [Current | Acc]);
        [_] -> lists:reverse([Current | Acc])
    end.