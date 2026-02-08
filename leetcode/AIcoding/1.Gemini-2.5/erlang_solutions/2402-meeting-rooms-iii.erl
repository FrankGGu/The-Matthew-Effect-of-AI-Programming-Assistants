-module(solution).
-export([mostBooked/2]).

-define(INFINITY, 1 bsl 60). % A sufficiently large number to represent infinity

update_list_at_idx(List, Idx, NewVal) ->
    lists:replace_at(Idx + 1, NewVal, List).

find_best_room(RoomsFreeTime, N, AccEarliestFreeTime, AccEarliestRoomIdx, CurrentRoomIdx) ->
    if CurrentRoomIdx >= N ->
        AccEarliestRoomIdx;
    true ->
        RoomFreeAt = lists:nth(CurrentRoomIdx + 1, RoomsFreeTime), % lists:nth uses 1-based indexing
        if RoomFreeAt < AccEarliestFreeTime ->
            find_best_room(RoomsFreeTime, N, RoomFreeAt, CurrentRoomIdx, CurrentRoomIdx + 1);
        RoomFreeAt == AccEarliestFreeTime ->
            % If same free time, keep the room with the smaller index (AccEarliestRoomIdx is already smaller or equal)
            find_best_room(RoomsFreeTime, N, AccEarliestFreeTime, AccEarliestRoomIdx, CurrentRoomIdx + 1);
        true -> % RoomFreeAt > AccEarliestFreeTime
            find_best_room(RoomsFreeTime, N, AccEarliestFreeTime, AccEarliestRoomIdx, CurrentRoomIdx + 1)
        end
    end.

find_max_booked_room(MeetingCounts, N, MaxCount, MaxRoomIdx, CurrentRoomIdx) ->
    if CurrentRoomIdx >= N ->
        MaxRoomIdx;
    true ->
        CurrentCount = lists:nth(CurrentRoomIdx + 1, MeetingCounts), % lists:nth uses 1-based indexing
        if CurrentCount > MaxCount ->
            find_max_booked_room(MeetingCounts, N, CurrentCount, CurrentRoomIdx, CurrentRoomIdx + 1);
        true -> % CurrentCount <= MaxCount. If CurrentCount == MaxCount, we keep the existing MaxRoomIdx (which is smaller or equal).
            find_max_booked_room(MeetingCounts, N, MaxCount, MaxRoomIdx, CurrentRoomIdx + 1)
        end
    end.

mostBooked(N, Meetings) ->
    % Sort meetings by start time. If start times are equal, order doesn't matter for room selection logic.
    SortedMeetings = lists:sort(fun([S1,_], [S2,_]) -> S1 =< S2 end, Meetings),

    % Initialize room_free_time (all rooms free at time 0)
    % Initialize meeting_counts (all rooms have 0 meetings)
    RoomsFreeTime = lists:duplicate(N, 0),
    MeetingCounts = lists:duplicate(N, 0),

    % Process each meeting
    {_FinalRoomsFreeTime, FinalMeetingCounts} = lists:foldl(
        fun([Start, End], {CurrentRoomsFreeTime, CurrentMeetingCounts}) ->
            Duration = End - Start,

            % Find the best room: earliest free time, then smallest index
            % Initial values for accumulator: INFINITY for time, 0 for index (will be overwritten if N > 0)
            BestRoomIdx = find_best_room(CurrentRoomsFreeTime, N, ?INFINITY, 0, 0),

            RoomBecomesFreeAt = lists:nth(BestRoomIdx + 1, CurrentRoomsFreeTime),

            NewRoomFreeTime =
                if RoomBecomesFreeAt =< Start ->
                    % Room is free before or at meeting start, so meeting starts on time
                    Start + Duration;
                true ->
                    % Room is not free, meeting waits until room becomes free
                    RoomBecomesFreeAt + Duration
                end,

            % Update RoomsFreeTime for the chosen room
            UpdatedRoomsFreeTime = update_list_at_idx(CurrentRoomsFreeTime, BestRoomIdx, NewRoomFreeTime),

            % Increment MeetingCounts for the chosen room
            CurrentCount = lists:nth(BestRoomIdx + 1, CurrentMeetingCounts),
            UpdatedMeetingCounts = update_list_at_idx(CurrentMeetingCounts, BestRoomIdx, CurrentCount + 1),

            {UpdatedRoomsFreeTime, UpdatedMeetingCounts}
        end,
        {RoomsFreeTime, MeetingCounts},
        SortedMeetings
    ),

    % Find the room with the maximum meeting count.
    % Initial MaxCount is -1 to ensure any valid count (0 or more) is picked.
    % Initial MaxRoomIdx is 0, assuming N > 0.
    find_max_booked_room(FinalMeetingCounts, N, -1, 0, 0).