-module(solution).
-export([min_score_path/2]).

min_score_path(_N, Roads) ->
    Adj = lists:foldl(fun([A, B, D], Acc) ->
        Acc1 = maps:update_with(A, fun(L) -> [{B, D} | L] end, [{B, D}], Acc),
        maps:update_with(B, fun(L) -> [{A, D} | L] end, [{A, D}], Acc1)
    end, maps:new(), Roads),

    Queue = queue:in(1, queue:new()),
    Visited = sets:add_element(1, sets:new()),
    MinScore = 1000000001,

    bfs(Queue, Visited, Adj, MinScore).

bfs(Queue, Visited, Adj, CurrentMinScore) ->
    case queue:out(Queue) of
        {{value, City}, RemainingQueue} ->
            Neighbors = maps:get(City, Adj, []),

            {NewQueue, NewVisited, NewMinScore} =
                lists:foldl(fun({Neighbor, Weight}, {AccQ, AccV, AccMS}) ->
                    UpdatedMinScore = min(AccMS, Weight),
                    if sets:is_element(Neighbor, AccV) ->
                        {AccQ, AccV, UpdatedMinScore};
                    else
                        {queue:in(Neighbor, AccQ), sets:add_element(Neighbor, AccV), UpdatedMinScore}
                    end
                end, {RemainingQueue, Visited, CurrentMinScore}, Neighbors),

            bfs(NewQueue, NewVisited, Adj, NewMinScore);
        {empty, _} ->
            CurrentMinScore
    end.