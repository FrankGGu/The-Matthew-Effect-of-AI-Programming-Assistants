-module(maximum_points).
-export([max_points/1]).

max_points(Points) ->
    max_points(Points, length(Points), 0, 0).

max_points([], 0, Best, _) -> Best;
max_points(_, 0, Best, _) -> Best;
max_points([H|T], Index, Best, Last) ->
    Max = max_points(T, Index - 1, Best, 0),
    if 
        Index - 1 < Last -> 
            max(Max, H + max_points(T, Index - 1, Best, Last + 1));
        true -> 
            max(Max, H + max_points(T, Index - 1, Best, Last))
    end.