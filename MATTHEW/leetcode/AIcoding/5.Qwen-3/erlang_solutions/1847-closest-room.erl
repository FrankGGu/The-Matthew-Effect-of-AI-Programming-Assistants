-module(closest_room).
-export([findClosestRooms/2]).

findClosestRooms(Workers, Rooms) ->
    SortedRooms = lists:sort(fun({Id1, Size1}, {Id2, Size2}) -> Size1 < Size2 end, Rooms),
    WorkerList = lists:sort(fun({Id1, Pos1}, {Id2, Pos2}) -> Pos1 < Pos2 end, Workers),
    Results = lists:map(fun({WorkerId, WorkerPos}) ->
        findClosestRoom(WorkerPos, SortedRooms)
    end, WorkerList),
    Results.

findClosestRoom(Pos, Rooms) ->
    lists:foldl(fun({Id, Size}, {MinDist, MinId, MinSize}) ->
        Dist = abs(Pos - Id),
        if
            Dist < MinDist -> {Dist, Id, Size};
            Dist == MinDist andalso Id < MinId -> {Dist, Id, Size};
            true -> {MinDist, MinId, MinSize}
        end
    end, {infinity, 0, 0}, Rooms).