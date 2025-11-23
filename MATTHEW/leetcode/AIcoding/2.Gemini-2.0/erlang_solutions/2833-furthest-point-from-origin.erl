-module(furthest_point).
-export([solve/1]).

solve(S) ->
    solve_helper(S, 0, 0).

solve_helper([], X, Y) ->
    abs(X) + abs(Y);
solve_helper([H|T], X, Y) ->
    case H of
        'L' ->
            solve_helper(T, X - 1, Y);
        'R' ->
            solve_helper(T, X + 1, Y);
        '_' ->
            Max1 = solve_helper(T, X + 1, Y),
            Max2 = solve_helper(T, X - 1, Y),
            Max3 = solve_helper(T, X, Y + 1),
            Max4 = solve_helper(T, X, Y - 1),
            max(max(Max1, Max2), max(Max3, Max4))
    end.