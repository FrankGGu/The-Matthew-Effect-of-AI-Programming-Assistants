-module(solution).
-export([solve/2]).

solve(Left, Right) ->
    Count = 0,
    solve(Left, Right, Count).

solve(N, Right, Count) when N > Right ->
    Count;
solve(N, Right, Count) ->
    case is_special(N) of
        true ->
            solve(N + 1, Right, Count);
        false ->
            solve(N + 1, Right, Count + 1)
    end.

is_special(N) ->
    Max = trunc(math:sqrt(N)),
    lists:any(fun(I) -> N rem I == 0 andalso I * I /= N end, lists:seq(1, Max)).