-module(count_substrings).
-export([solve/2]).

solve(S, C) ->
    solve(S, C, 0, 0).

solve([], _, Acc, Count) ->
    Count;
solve([H|T], C, Acc, Count) ->
    case H =:= C of
        true ->
            solve(T, C, Acc + 1, Count + Acc + 1);
        false ->
            solve(T, C, Acc, Count)
    end.