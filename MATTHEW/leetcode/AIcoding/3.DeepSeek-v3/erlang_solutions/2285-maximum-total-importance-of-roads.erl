-spec maximum_importance(N :: integer(), Roads :: [[integer()]]) -> integer().
maximum_importance(N, Roads) ->
    Degree = lists:foldl(fun([A, B], Acc) ->
                            Acc1 = maps:update_with(A, fun(V) -> V + 1 end, 1, Acc),
                            maps:update_with(B, fun(V) -> V + 1 end, 1, Acc1)
                         end, #{}, Roads),
    Nodes = lists:seq(0, N - 1),
    SortedNodes = lists:sort(fun(A, B) ->
                                maps:get(A, Degree, 0) > maps:get(B, Degree, 0)
                             end, Nodes),
    Importance = lists:foldl(fun(Node, {Rank, Sum}) ->
                                NewSum = Sum + maps:get(Node, Degree, 0) * Rank,
                                {Rank + 1, NewSum}
                             end, {1, 0}, SortedNodes),
    element(2, Importance).