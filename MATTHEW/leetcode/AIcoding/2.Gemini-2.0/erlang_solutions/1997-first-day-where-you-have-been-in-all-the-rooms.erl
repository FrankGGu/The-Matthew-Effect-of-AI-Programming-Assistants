-module(first_day).
-export([first_day_been_in_all_rooms/1]).

first_day_been_in_all_rooms(NextVisit) ->
    N = length(NextVisit),
    {_, LastDay} = solve(NextVisit, N, 0, 0, [0]),
    LastDay.

solve(_NextVisit, N, Day, LastDay, Rooms) when length(Rooms) == N ->
    {Rooms, LastDay};
solve(NextVisit, N, Day, LastDay, Rooms) ->
    case lists:member(Day, Rooms) of
        true ->
            NextRoom = Day + 1,
            NextDay = (Day - NextVisit !! Day + N) rem N,
            NewDay = max(Day + 1, NextDay),
            solve(NextVisit, N, NextRoom, NewDay, Rooms ++ [NextRoom]);
        false ->
            solve(NextVisit, N, Day, LastDay, Rooms)
    end.