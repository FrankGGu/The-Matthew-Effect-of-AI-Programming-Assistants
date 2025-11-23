-module(max_darts).
-export([max_number_of_darts/1]).

max_number_of_darts(Points) ->
    case length(Points) of
        1 -> 1;
        _ -> max_darts_helper(Points, 0)
    end.

max_darts_helper([], Max) ->
    Max;
max_darts_helper([P | Rest], Max) ->
    Count = count_points_with_same_circle(P, Rest),
    NewMax = max(Max, Count),
    max_darts_helper(Rest, NewMax).

count_points_with_same_circle(P, Points) ->
    count_points_with_same_circle(P, Points, 0).

count_points_with_same_circle(_, [], Count) ->
    Count + 1;
count_points_with_same_circle(P, [Q | Rest], Count) ->
    if P == Q -> count_points_with_same_circle(P, Rest, Count + 1);
       true -> count_points_with_same_circle(P, Rest, Count)
    end.