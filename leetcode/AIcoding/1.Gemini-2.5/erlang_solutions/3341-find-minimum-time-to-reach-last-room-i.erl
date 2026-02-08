-module(solution).
-export([min_time_to_reach_last_room/2]).

min_time_to_reach_last_room(ReleaseTimes, Durations) ->
    solve(ReleaseTimes, Durations, 0).

solve([], [], FinalFinishTime) ->
    FinalFinishTime;
solve([R | Rs], [D | Ds], PrevRoomFinishTime) ->
    EntryTime = erlang:max(PrevRoomFinishTime, R),
    FinishTime = EntryTime + D,
    solve(Rs, Ds, FinishTime).