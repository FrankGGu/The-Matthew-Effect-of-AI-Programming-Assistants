-module(hashed_divided_string).
-export([solve/1]).

solve(S) ->
    solve(S, 0, 0).

solve([], _, _) ->
    true;
solve([C | T], Index, Hash) ->
    Hash1 = (Hash + C) rem 256,
    if
        Index == 0 ->
            solve(T, Index + 1, Hash1);
        true ->
            Hash2 = (Hash1 * 31 + C) rem 256,
            solve(T, Index + 1, Hash2)
    end.