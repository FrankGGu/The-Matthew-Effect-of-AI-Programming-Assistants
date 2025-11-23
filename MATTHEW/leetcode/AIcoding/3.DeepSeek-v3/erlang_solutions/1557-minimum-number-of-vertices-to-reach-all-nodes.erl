-spec find_smallest_set_of_vertices(N :: integer(), Edges :: [[integer()]]) -> [integer()].
find_smallest_set_of_vertices(N, Edges) ->
    InDegree = lists:foldl(fun([_, To], Acc) ->
                                maps:update_with(To, fun(V) -> V + 1 end, 1, Acc)
                           end, maps:new(), Edges),
    lists:filter(fun(Node) -> not maps:is_key(Node, InDegree) end, lists:seq(0, N - 1)).