-module(find_minimum_time_to_reach_last_room_i).
-export([minimum_time/1]).

minimum_time(corridors) ->
    minimum_time(corridors, 1, 0, []).

minimum_time([], _, Time, _) ->
    Time;
minimum_time([H|T], CurrentRoom, Time, Visited) ->
    NextRooms = lists:filter(fun({R1, R2, _}) -> R1 == CurrentRoom orelse R2 == CurrentRoom end, H),
    NextRoomsWithTime = lists:map(fun({R1, R2, T}) ->
                                      case R1 == CurrentRoom of
                                          true -> {R2, T};
                                          false -> {R1, T}
                                      end
                                  end, NextRooms),
    NextRoomsFiltered = lists:filter(fun({Room, _}) -> not lists:member(Room, Visited) end, NextRoomsWithTime),
    case NextRoomsFiltered of
        [] ->
            Time + 1;
        _ ->
            SortedNextRooms = lists:keysort(2, NextRoomsFiltered),
            {NextRoom, NextTime} = lists:nth(1, SortedNextRooms),
            minimum_time(T, NextRoom, max(Time + 1, NextTime), [CurrentRoom | Visited])
    end.