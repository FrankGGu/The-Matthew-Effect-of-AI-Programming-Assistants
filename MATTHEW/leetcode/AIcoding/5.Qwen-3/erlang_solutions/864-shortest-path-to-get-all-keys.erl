-module(solution).
-export([shortestPathAllKeys/1]).

shortestPathAllKeys(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {StartX, StartY} = findStart(Grid),
    Keys = countKeys(Grid),
    State = {StartX, StartY, 0},
    BFS([State], Grid, Rows, Cols, 0, Keys, maps:new()).

findStart(Grid) ->
    findStart(Grid, 0, 0).

findStart([], _, _) -> {0, 0};
findStart([Row | Rest], X, Y) ->
    case lists:keymember($@, 1, Row) of
        true -> {X, Y};
        false -> findStart(Rest, X + 1, 0)
    end.

countKeys(Grid) ->
    countKeys(Grid, 0).

countKeys([], Count) -> Count;
countKeys([Row | Rest], Count) ->
    NewCount = Count + length([C || C <- Row, isKey(C)]),
    countKeys(Rest, NewCount).

isKey(Char) when Char >= $a, Char =< $f -> true;
isKey(_) -> false.

BFS(Queue, Grid, Rows, Cols, Steps, TargetKeys, Visited) ->
    case Queue of
        [] -> -1;
        _ ->
            NextQueue = [],
            {NewQueue, Found} = processQueue(Queue, Grid, Rows, Cols, Steps, TargetKeys, Visited, NextQueue),
            if
                Found -> Steps;
                true -> BFS(NewQueue, Grid, Rows, Cols, Steps + 1, TargetKeys, Visited)
            end
    end.

processQueue([], _, _, _, _, _, _, Acc) -> {Acc, false};
processQueue([State | Rest], Grid, Rows, Cols, Steps, TargetKeys, Visited, Acc) ->
    {X, Y, Mask} = State,
    Key = getCell(Grid, X, Y),
    NewMask = if
                  isKey(Key) -> Mask bor (1 bsl (Key - $a));
                  true -> Mask
              end,
    if
        NewMask == TargetKeys -> {Acc, true};
        true ->
            NewVisited = maps:put({X, Y, NewMask}, true, Visited),
            Neighbors = getNeighbors(X, Y, Rows, Cols),
            {NewAcc, Found} = processNeighbors(Neighbors, Grid, X, Y, NewMask, TargetKeys, NewVisited, Acc),
            processQueue(Rest, Grid, Rows, Cols, Steps, TargetKeys, Visited, [NewAcc | Found])
    end.

processNeighbors([], _, _, _, _, _, _, Acc) -> {Acc, false};
processNeighbors([Neighbor | Rest], Grid, X, Y, Mask, TargetKeys, Visited, Acc) ->
    {NX, NY} = Neighbor,
    Cell = getCell(Grid, NX, NY),
    if
        Cell == $# -> processNeighbors(Rest, Grid, X, Y, Mask, TargetKeys, Visited, Acc);
        true ->
            Key = getCell(Grid, NX, NY),
            NewMask = if
                          isKey(Key) -> Mask bor (1 bsl (Key - $a));
                          true -> Mask
                      end,
            if
                maps:get({NX, NY, NewMask}, Visited, false) -> processNeighbors(Rest, Grid, X, Y, Mask, TargetKeys, Visited, Acc);
                true -> processNeighbors(Rest, Grid, X, Y, Mask, TargetKeys, Visited, [{NX, NY, NewMask} | Acc])
            end
    end.

getCell(Grid, X, Y) ->
    lists:nth(Y + 1, lists:nth(X + 1, Grid)).

getNeighbors(X, Y, Rows, Cols) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    [ {X + DX, Y + DY} || {DX, DY} <- Directions, X + DX >= 0, X + DX < Rows, Y + DY >= 0, Y + DY < Cols ].