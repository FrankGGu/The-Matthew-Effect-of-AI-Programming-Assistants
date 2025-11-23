-module(minimum_replacements).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 0).

solve([], _, Acc) ->
    Acc;
solve([H | T], Pos, Acc) ->
    case T of
        [] ->
            Acc;
        _ ->
            if
                H < lists:nth(Pos + 2, T) ->
                    solve(T, Pos + 1, Acc);
                true ->
                    solve(T, Pos + 1, Acc + 1)
            end
    end.