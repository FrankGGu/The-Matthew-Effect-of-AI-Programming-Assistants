-module(solution).
-export([minimum_effort_path/1]).

minimum_effort_path(Heights) ->
    {Rows, Cols} = {length(Heights), length(hd(Heights))},
    Dist = lists:duplicate(Rows * Cols, 16#3f3f3f3f),
    Dist1 = setelement(1, Dist, 0),
    Queue = [{0, 0, 0}],
    dijkstra(Heights, Queue, Dist1, Rows, Cols).

dijkstra(_, [], Dist, _, _) ->
    element(length(Dist), Dist);
dijkstra(Heights, [{Effort, X, Y} | Rest], Dist, Rows, Cols) ->
    case element(X * Cols + Y + 1, Dist) < Effort of
        true -> dijkstra(Heights, Rest, Dist, Rows, Cols);
        false ->
            NewDist = setelement(X * Cols + Y + 1, Dist, Effort),
            Neighbors = [{NX, NY} || {NX, NY} <- [{X+1, Y}, {X-1, Y}, {X, Y+1}, {X, Y-1}],
                                     NX >= 0, NX < Rows, NY >= 0, NY < Cols],
            NewQueue = lists:foldl(
                fun({NX, NY}, Acc) ->
                    NewEffort = max(Effort, abs(lists:nth(NX+1, lists:nth(NY+1, Heights)) - lists:nth(X+1, lists:nth(Y+1, Heights)))),
                    case NewEffort < element(NX * Cols + NY + 1, NewDist) of
                        true -> [{NewEffort, NX, NY} | Acc];
                        false -> Acc
                    end
                end, Rest, Neighbors),
            dijkstra(Heights, lists:keysort(1, NewQueue), NewDist, Rows, Cols)
    end.