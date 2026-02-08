-module(solution).
-export([maxDistToClosest/1]).

maxDistToClosest(Seats) ->
    MaxDist = lists:max([max_distance(Seats, I) || I <- lists:seq(0, length(Seats) - 1)]),
    MaxDist.

max_distance(Seats, Index) ->
    case lists:nth(Index + 1, Seats) of
        1 -> 0;
        _ -> 
            LeftDist = find_left_distance(Seats, Index),
            RightDist = find_right_distance(Seats, Index),
            min(LeftDist, RightDist)
    end.

find_left_distance(Seats, Index) ->
    find_distance(Seats, Index, -1).

find_right_distance(Seats, Index) ->
    find_distance(Seats, Index, 1).

find_distance(Seats, Index, Direction) ->
    case lists:nth(Index + 1, Seats) of
        1 -> 0;
        _ -> 
            NewIndex = Index + Direction,
            case NewIndex of
                I when I < 0 -> infinity;
                I when I >= length(Seats) -> infinity;
                _ -> 1 + find_distance(Seats, NewIndex, Direction)
            end
    end.