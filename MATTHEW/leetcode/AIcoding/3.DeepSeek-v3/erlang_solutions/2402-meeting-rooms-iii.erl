-module(meeting_rooms_iii).
-export([most_booked/2]).

most_booked(N, Meetings) ->
    SortedMeetings = lists:sort(fun([A, B], [C, D]) -> A =< C end, Meetings),
    Rooms = lists:duplicate(N, {0, 0}),
    process_meetings(SortedMeetings, Rooms, lists:seq(0, N - 1), []).

process_meetings([], Rooms, _, _) ->
    {MaxCount, _} = lists:max(Rooms),
    lists:foldl(fun({Count, Room}, {CurrentMax, Result}) ->
                    if
                        Count > CurrentMax -> {Count, Room};
                        Count == CurrentMax andalso Room < Result -> {Count, Room};
                        true -> {CurrentMax, Result}
                    end
                end, {-1, -1}, lists:zipwith(fun(Room, Idx) -> {element(1, Room), Idx} end, Rooms, lists:seq(0, length(Rooms) - 1))),
    element(2, lists:foldl(fun({Count, Room}, {CurrentMax, Result}) ->
                    if
                        Count > CurrentMax -> {Count, Room};
                        Count == CurrentMax andalso Room < Result -> {Count, Room};
                        true -> {CurrentMax, Result}
                    end
                end, {-1, -1}, lists:zipwith(fun(Room, Idx) -> {element(1, Room), Idx} end, Rooms, lists:seq(0, length(Rooms) - 1))));
process_meetings([[Start, End] | Rest], Rooms, Available, Busy) ->
    {NewRooms, NewAvailable, NewBusy} = assign_room(Start, End, Rooms, Available, Busy),
    process_meetings(Rest, NewRooms, NewAvailable, NewBusy).

assign_room(Start, End, Rooms, Available, Busy) ->
    case Available of
        [] ->
            {EarliestEnd, RoomId} = lists:min(Busy),
            {Count, _} = lists:nth(RoomId + 1, Rooms),
            NewRooms = setelement(RoomId + 1, Rooms, {Count + 1, EarliestEnd + End - Start}),
            NewBusy = lists:keyreplace(EarliestEnd, 1, Busy, {EarliestEnd + End - Start, RoomId}),
            {NewRooms, [], NewBusy};
        [RoomId | RestAvailable] ->
            {Count, _} = lists:nth(RoomId + 1, Rooms),
            NewRooms = setelement(RoomId + 1, Rooms, {Count + 1, End}),
            NewBusy = lists:sort([{End, RoomId} | Busy]),
            {NewRooms, RestAvailable, NewBusy}
    end.