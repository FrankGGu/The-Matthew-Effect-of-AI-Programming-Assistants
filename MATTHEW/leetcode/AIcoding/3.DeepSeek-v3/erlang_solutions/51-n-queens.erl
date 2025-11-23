-module(solution).
-export([solve_n_queens/1]).

solve_n_queens(N) ->
    solve(N, 0, [], [], []).

solve(N, Row, Queens, Diags1, Diags2) when Row =:= N ->
    [lists:duplicate(N, $.)];
solve(N, Row, Queens, Diags1, Diags2) ->
    [[$Q || Col <- lists:seq(0, N-1),
            not lists:member(Col, Queens),
            not lists:member(Row + Col, Diags1),
            not lists:member(Row - Col, Diags2),
            begin
                NewQueens = [Col | Queens],
                NewDiags1 = [Row + Col | Diags1],
                NewDiags2 = [Row - Col | Diags2],
                Rest = solve(N, Row + 1, NewQueens, NewDiags1, NewDiags2),
                [ [if K =:= Col -> $Q; true -> $. end || K <- lists:seq(0, N-1)] | B] || B <- Rest
            end]].