-module(solution).
-export([solve/1]).

solve(S) ->
    solve(S, 0).

solve([], _) ->
    0;
solve([H|T], Count) ->
    case H of
        $- -> solve(T, Count + 1);
        _ -> solve(T, Count)
    end.