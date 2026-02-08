-module(make_array_non_decreasing).
-export([solve/1]).

solve(Rows) ->
    solve(Rows, 0, 0).

solve([], _, _) ->
    true;
solve([H | T], Prev, Count) ->
    if
        H >= Prev ->
            solve(T, H, Count);
        true ->
            case Count of
                0 ->
                    solve(T, H, 1);
                _ ->
                    false
            end
    end.