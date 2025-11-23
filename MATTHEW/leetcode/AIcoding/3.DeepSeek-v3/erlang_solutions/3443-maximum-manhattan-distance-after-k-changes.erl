-module(solution).
-export([max_manhattan_distance/2]).

max_manhattan_distance(Points, K) ->
    N = length(Points),
    if 
        N == 0 -> 0;
        true ->
            Xs = lists:map(fun([X, _Y]) -> X end, Points),
            Ys = lists:map(fun([_X, Y]) -> Y end, Points),
            {MinX, MaxX} = min_max(Xs),
            {MinY, MaxY} = min_max(Ys),
            D1 = (MaxX - MinX) + (MaxY - MinY),
            if
                K == 0 -> D1;
                true ->
                    D2 = (max_diff(Xs) + max_diff(Ys)) * 2,
                    max(D1, D2)
            end
    end.

min_max(List) ->
    Min = lists:min(List),
    Max = lists:max(List),
    {Min, Max}.

max_diff(List) ->
    Sorted = lists:sort(List),
    lists:max([abs(X - Y) || {X, Y} <- lists:zip(Sorted, tl(Sorted))]).