-module(solution).
-export([solve/1]).

solve(S) ->
    solve(S, []).

solve([], Acc) ->
    lists:reverse(Acc);
solve([H | T], Acc) ->
    case Acc of
        [] ->
            solve(T, [H]);
        [H | _] ->
            solve(T, Acc);
        _ ->
            solve(T, [H | Acc])
    end.