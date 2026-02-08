-module(semi_ordered_permutation).
-export([solve/1]).

solve(P) ->
    solve(P, 0).

solve([], _Acc) ->
    _Acc;
solve([1 | T], Acc) ->
    solve(T, Acc);
solve([X | T], Acc) ->
    case lists:keyfind(1, 1, T) of
        false ->
            solve(T, Acc + 1);
        {_, Pos} ->
            solve(lists:split(Pos, [X | T]), Acc + Pos + 1)
    end.

solve({Left, Right}, Acc) ->
    solve(Left ++ [1 | Right], Acc).