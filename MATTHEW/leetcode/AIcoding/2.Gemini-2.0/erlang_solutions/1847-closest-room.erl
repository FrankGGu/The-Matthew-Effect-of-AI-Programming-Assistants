-module(closest_room).
-export([closest_room/2]).

closest_room(Rooms, Queries) ->
    SortedRooms = lists:sort(fun({_, Size1}, {_, Size2}) -> Size1 > Size2 end, Rooms),
    [find_closest(RoomId, MinSize, SortedRooms) || {RoomId, MinSize} <- Queries].

find_closest(RoomId, MinSize, SortedRooms) ->
    FilteredRooms = lists:filter(fun({_, Size}) -> Size >= MinSize end, SortedRooms),
    case FilteredRooms of
        [] -> -1;
        [FirstRoom | RestRooms] ->
            lists:foldl(fun({Id, _}, Acc) ->
                                 case Acc of
                                     -1 -> Id;
                                     AccId ->
                                         Diff1 = abs(Id - RoomId),
                                         Diff2 = abs(AccId - RoomId),
                                         if Diff1 < Diff2 -> Id;
                                            Diff1 > Diff2 -> AccId;
                                            true -> min(Id, AccId)
                                         end
                                 end
                             end,
                        lists:nth(1, FirstRoom),
                        RestRooms)
    end.