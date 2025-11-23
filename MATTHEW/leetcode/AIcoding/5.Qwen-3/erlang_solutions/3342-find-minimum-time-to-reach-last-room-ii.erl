-module(find_minimum_time_to_reach_last_room_ii).
-export([calculate/1]).

calculate(Rooms) ->
    N = length(Rooms),
    {_, _, Max} = lists:foldl(fun(I, {Pos, Time, Max}) ->
        Room = lists:nth(I + 1, Rooms),
        NewTime = max(Time + 1, Pos + 1 - I),
        NewMax = max(Max, NewTime),
        {I, NewTime, NewMax}
    end, {-1, 0, 0}, lists:seq(0, N - 1)),
    Max.