-module(solution).
-export([updateMatrix/1]).

updateMatrix(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> [];
        true ->
            Cols = length(hd(Matrix)),
            Dist = [[-1 || _ <- lists:seq(1, Cols)] || _ <- lists:seq(1, Rows)],
            Queue = queue:new(),
            fillQueue(Matrix, Dist, Queue, Rows, Cols),
            bfs(Dist, Queue, Rows, Cols)
    end.

fillQueue([], _, Q, _, _) -> Q;
fillQueue([Row | Rest], Dist, Q, Rows, Cols) ->
    fillRow(Row, 0, 0, Dist, Q, Rows, Cols),
    fillQueue(Rest, Dist, Q, Rows, Cols).

fillRow([], _, _, _, Q, _, _) -> Q;
fillRow([Val | Rest], Row, Col, Dist, Q, Rows, Cols) ->
    if
        Val == 0 ->
            NewDist = lists:sublist(Dist, Row) ++ [0 | lists:nthtail(Col + 1, lists:nth(Row, Dist))],
            NewQ = queue:in({Row, Col}, Q),
            fillRow(Rest, Row, Col + 1, NewDist, NewQ, Rows, Cols);
        true ->
            fillRow(Rest, Row, Col + 1, Dist, Q, Rows, Cols)
    end.

bfs(Dist, Queue, Rows, Cols) ->
    case queue:out(Queue) of
        {empty, _} -> Dist;
        {{value, {R, C}}, NewQueue} ->
            Neighbors = [
                {R - 1, C},
                {R + 1, C},
                {R, C - 1},
                {R, C + 1}
            ],
            UpdatedDist = updateNeighbors(Dist, Neighbors, R, C, NewQueue),
            bfs(UpdatedDist, NewQueue, Rows, Cols)
    end.

updateNeighbors(Dist, [], _, _, Q) -> Dist;
updateNeighbors(Dist, [{NR, NC} | Rest], R, C, Q) ->
    if
        NR >= 0, NR < length(Dist), NC >= 0, NC < length(hd(Dist)), lists:nth(NR + 1, Dist) -- [NC + 1] == -1 ->
            NewDist = lists:sublist(Dist, NR) ++ [lists:sublist(lists:nth(NR + 1, Dist), NC) ++ [lists:nth(NR + 1, Dist) -- [NC + 1] + 1 | lists:nthtail(NC + 1, lists:nth(NR + 1, Dist))] ++ lists:nthtail(NR + 1, Dist)],
            NewQ = queue:in({NR, NC}, Q),
            updateNeighbors(NewDist, Rest, R, C, NewQ);
        true ->
            updateNeighbors(Dist, Rest, R, C, Q)
    end.