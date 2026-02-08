-module(solution).
-export([solve/1]).

solve(Board) ->
    solve(Board, 0, 0, 0, 0, 0).

solve([], _, _, _, _, _) ->
    0;
solve([Row | Rest], X, Y, MaxX, MaxY, Count) ->
    case Row of
        [H | T] when H == $R ->
            NewCount = Count + 1,
            solve(Rest, X + 1, Y, MaxX, MaxY, NewCount);
        [H | T] when H == $B ->
            NewCount = Count + 1,
            solve(Rest, X, Y + 1, MaxX, MaxY, NewCount);
        _ ->
            solve(Rest, X, Y, MaxX, MaxY, Count)
    end.