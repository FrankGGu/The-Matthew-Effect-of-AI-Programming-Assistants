-module(meeting_rooms_iii).
-export([meeting_rooms_iii/1]).

meeting_rooms_iii(Meetings) ->
    N = max_room(Meetings),
    meeting_rooms_iii_helper(Meetings, N).

meeting_rooms_iii_helper(Meetings, N) ->
    Used_rooms = array:new(N, {fixed, 0}),
    Room_counts = array:new(N, {fixed, 0}),
    meeting_rooms_iii_iterate(Meetings, array:size(Used_rooms), Used_rooms, Room_counts, 0, 0).

meeting_rooms_iii_iterate([], _N, _Used_rooms, Room_counts, Max_count, Best_room) ->
    find_best_room(array:list(Room_counts), 0, 0, 0);
meeting_rooms_iii_iterate([Meeting | Rest], N, Used_rooms, Room_counts, Max_count, Best_room) ->
    {Start, End} = Meeting,
    Available_room = find_available_room(Used_rooms, N, Start, 0),

    case Available_room of
        -1 ->
            {Earliest_end, Room_index} = find_earliest_ending(Used_rooms, N, Start, {infinity, -1}, 0),
            Current_end = array:get(Room_index, Used_rooms),
            New_start = max(Start, Current_end),
            New_end = New_start + (End - Start),
            Used_rooms1 = array:set(Room_index, New_end, Used_rooms),
            Room_counts1 = array:set(Room_index, array:get(Room_index, Room_counts) + 1, Room_counts),
            meeting_rooms_iii_iterate(Rest, N, Used_rooms1, Room_counts1, Max_count, Best_room);
        Room_index ->
            Used_rooms1 = array:set(Room_index, End, Used_rooms),
            Room_counts1 = array:set(Room_index, array:get(Room_index, Room_counts) + 1, Room_counts),
            meeting_rooms_iii_iterate(Rest, N, Used_rooms1, Room_counts1, Max_count, Best_room)
    end.

find_available_room(Used_rooms, N, Start, Index) ->
    if Index >= N then
        -1
    else
        End_time = array:get(Index, Used_rooms),
        if End_time =:= 0 orelse End_time =< Start then
            Index
        else
            find_available_room(Used_rooms, N, Start, Index + 1)
        end
    end.

find_earliest_ending(Used_rooms, N, Start, Acc, Index) ->
    if Index >= N then
        Acc
    else
        End_time = array:get(Index, Used_rooms),
        if End_time =:= 0 then
            find_earliest_ending(Used_rooms, N, Start, Acc, Index + 1)
        else
             {Earliest_end, _} = Acc,
            if End_time < Earliest_end then
                find_earliest_ending(Used_rooms, N, Start, {End_time, Index}, Index + 1)
            else
                find_earliest_ending(Used_rooms, N, Start, Acc, Index + 1)
            end
        end
    end.

find_best_room([], Max_count, Best_room, Index) ->
    Best_room;
find_best_room([Count | Rest], Max_count, Best_room, Index) ->
    if Count > Max_count then
        find_best_room(Rest, Count, Index, Index + 1)
    else
        find_best_room(Rest, Max_count, Best_room, Index + 1)
    end.

max_room(Meetings) ->
    lists:foldl(fun({S, E}, Acc) -> max(max(S, E), Acc) end, 0, Meetings).