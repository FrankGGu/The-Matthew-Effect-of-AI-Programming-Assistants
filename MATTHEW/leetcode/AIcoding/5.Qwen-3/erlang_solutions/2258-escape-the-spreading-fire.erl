-module(escape_the_spreading_fire).
-export([maximumMinutes/1]).

maximumMinutes(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {People, Fires} = collectPositions(Grid, 0, 0, [], []),
    BFS(People, Fires, Rows, Cols).

collectPositions([], _, _, People, Fires) ->
    {People, Fires};
collectPositions([Row | Rest], RowIdx, ColIdx, People, Fires) ->
    case ColIdx < length(Row) of
        true ->
            case lists:nth(ColIdx + 1, Row) of
                $P -> collectPositions(Row, RowIdx, ColIdx + 1, [ {RowIdx, ColIdx} | People ], Fires);
                $F -> collectPositions(Row, RowIdx, ColIdx + 1, People, [ {RowIdx, ColIdx} | Fires ]);
                _ -> collectPositions(Row, RowIdx, ColIdx + 1, People, Fires)
            end;
        false ->
            collectPositions(Rest, RowIdx + 1, 0, People, Fires)
    end.

BFS(People, Fires, Rows, Cols) ->
    Directions = [ {-1,0}, {1,0}, {0,-1}, {0,1} ],
    FireDist = fireDistance(Fires, Rows, Cols),
    PersonDist = personDistance(People, FireDist, Rows, Cols, Directions),
    lists:max(PersonDist).

fireDistance(Fires, Rows, Cols) ->
    Dist = array:new({Rows, Cols}, {default, -1}),
    Queue = queue:from_list(Fires),
    fireDistance(Queue, Dist, 0).

fireDistance(Queue, Dist, Time) ->
    case queue:is_empty(Queue) of
        true -> Dist;
        false ->
            { {value, {R, C}}, NewQueue } = queue:out(Queue),
            case array:get({R, C}, Dist) of
                -1 ->
                    array:set({R, C}, Time, Dist),
                    NextQueue = addNeighbors(Queue, NewQueue, R, C, Time + 1);
                    fireDistance(NextQueue, Dist, Time + 1);
                _ ->
                    fireDistance(NewQueue, Dist, Time)
            end
    end.

addNeighbors(Queue, NewQueue, R, C, Time) ->
    Directions = [ {-1,0}, {1,0}, {0,-1}, {0,1} ],
    lists:foldl(fun {DR, DC} ->
        NR = R + DR,
        NC = C + DC,
        if NR >= 0, NR < length(Queue), NC >= 0, NC < length(Queue) ->
            case array:get({NR, NC}, Queue) of
                -1 -> queue:in({NR, NC}, NewQueue);
                _ -> NewQueue
            end;
        true -> NewQueue
    end, NewQueue, Directions).

personDistance(People, FireDist, Rows, Cols, Directions) ->
    lists:map(fun {R, C} -> personDistanceHelper(R, C, FireDist, Rows, Cols, Directions, 0) end, People).

personDistanceHelper(R, C, FireDist, Rows, Cols, Directions, Time) ->
    case R < 0 orelse R >= Rows orelse C < 0 orelse C >= Cols of
        true -> -1;
        false ->
            case array:get({R, C}, FireDist) of
                -1 -> Time;
                FD when FD > Time -> Time;
                _ -> -1
            end
    end.

personDistanceHelper(R, C, FireDist, Rows, Cols, Directions, Time) ->
    case R < 0 orelse R >= Rows orelse C < 0 orelse C >= Cols of
        true -> -1;
        false ->
            case array:get({R, C}, FireDist) of
                -1 -> Time;
                FD when FD > Time -> Time;
                _ -> -1
            end
    end.

queue:from_list(List) ->
    queue:from_list(List).

array:new(Dims, _) ->
    erlang:make_tuple(Dims, -1).

array:get({R, C}, Array) ->
    element(R + 1, Array).

array:set({R, C}, Value, Array) ->
    erlang:append_element(Array, R + 1, Value).