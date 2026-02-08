-module(solution).
-export([totalNQueens/1]).

totalNQueens(N) ->
    solve(N, 0, 0, 0, 0).

solve(0, _, _, _, Count) ->
    Count;
solve(N, Cols, Diag1, Diag2, Count) ->
    Available = ((1 bsl N) - 1) band (bnot (Cols bor Diag1 bor Diag2)),
    solve_helper(N, Available, Cols, Diag1, Diag2, Count).

solve_helper(_, 0, _, _, _, Count) ->
    Count;
solve_helper(N, Available, Cols, Diag1, Diag2, Count) ->
    Pos = Available band -Available,
    NewAvailable = Available bxor Pos,
    NewCols = Cols bor Pos,
    NewDiag1 = (Diag1 bor Pos) bsl 1,
    NewDiag2 = (Diag2 bor Pos) bsr 1,
    NewCount = solve(N - 1, NewCols, NewDiag1, NewDiag2, Count),
    solve_helper(N, NewAvailable, Cols, Diag1, Diag2, NewCount).