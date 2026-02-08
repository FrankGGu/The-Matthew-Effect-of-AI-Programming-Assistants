-module(solution).
-export([maximum_moves/1]).

maximum_moves(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    DP = lists:duplicate(Rows, lists:duplicate(Cols, -1)),
    MaxMoves = lists:max([dfs(Row, 0, Board, DP) || Row <- lists:seq(0, Rows - 1)]),
    if MaxMoves == -1 -> 0; true -> MaxMoves - 1 end.

dfs(Row, Col, Board, DP) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    if Col == Cols - 1 -> 1;
       true ->
            case lists:nth(Row + 1, lists:nth(Col + 1, DP)) of
                -1 ->
                    Moves = [dfs(R, Col + 1, Board, DP) || R <- possible_moves(Row, Col, Board, Rows)],
                    ValidMoves = [M || M <- Moves, M =/= -1],
                    if ValidMoves == [] -> -1;
                       true -> 1 + lists:max(ValidMoves)
                    end;
                Val -> Val
            end
    end.

possible_moves(Row, Col, Board, Rows) ->
    Directions = [-1, 0, 1],
    [R || D <- Directions,
          R <- [Row + D],
          R >= 0,
          R < Rows,
          lists:nth(R + 1, lists:nth(Col + 1, Board)) == 1].