-module(solution).
-export([closest_room/2]).

closest_room(Rooms, Queries) ->
    SortedRooms = lists:sort(fun({_, Size1}, {_, Size2}) -> Size1 > Size2 end, Rooms),
    QueriesWithIndex = lists:map(fun({Index, Size}) -> {Index, Size, lists:nth(Index + 1, SortedRooms)} end, lists:zip(lists:seq(0, length(Queries) - 1), Queries)),
    lists:map(fun({Index, Size, Room}) -> closest_room_for_query(Room, Size) end, QueriesWithIndex).

closest_room_for_query(Room, Size) ->
    lists:filter(fun({Id, S}) -> S >= Size end, Room).