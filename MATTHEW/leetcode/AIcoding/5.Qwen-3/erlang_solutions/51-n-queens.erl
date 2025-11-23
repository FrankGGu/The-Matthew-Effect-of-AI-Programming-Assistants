-module(n_queens).
-export([solve_n_queens/1]).

solve_n_queens(N) ->
    solve([], N).

solve(Acc, N) ->
    solve(Acc, N, 0).

solve(Acc, N, Row) when Row >= N ->
    lists:reverse(Acc);
solve(Acc, N, Row) ->
    Possible = [Col || Col <- lists:seq(0, N-1), is_safe(Acc, Row, Col)],
    lists:foldl(fun(Col, Acc2) -> solve([[Row, Col] | Acc2], N, Row + 1) end, Acc, Possible).

is_safe(Queens, Row, Col) ->
    not lists:any(fun({R, C}) -> C == Col orelse R - C == Row - Col orelse R + C == Row + Col end, Queens).