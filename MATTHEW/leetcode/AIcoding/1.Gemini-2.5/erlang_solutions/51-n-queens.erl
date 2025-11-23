-module(solution).
-export([solveNQueens/1]).

solveNQueens(N) ->
    solve(0, N, [], []).

solve(N, N, CurrentBoardReversed, AccSolutions) ->
    [format_board(N, lists:reverse(CurrentBoardReversed)) | AccSolutions];
solve(Row, N, CurrentBoardReversed, AccSolutions) ->
    lists:foldl(fun(Col, Acc) ->
                    if is_safe(Row, Col, CurrentBoardReversed) ->
                           solve(Row + 1, N, [Col | CurrentBoardReversed], Acc);
                       true ->
                           Acc
                    end
                end, AccSolutions, lists:seq(0, N - 1)).

is_safe(Row, Col, PlacedQueensReversed) ->
    is_safe_check(Row, Col, PlacedQueensReversed, Row - 1).

is_safe_check(_Row, _Col, [], _PrevRow) ->
    true;
is_safe_check(Row, Col, [PrevCol | RestQueens], PrevRow) ->
    PrevCol =/= Col andalso
    abs(Row - PrevRow) =/= abs(Col - PrevCol) andalso
    is_safe_check(Row, Col, RestQueens, PrevRow - 1).

format_board(N, PlacedQueens) ->
    lists:map(fun(Col) ->
                  lists:duplicate(Col, $.) ++ [$Q] ++ lists:duplicate(N - 1 - Col, $.)
              end, PlacedQueens).