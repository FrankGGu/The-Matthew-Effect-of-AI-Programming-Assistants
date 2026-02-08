-module(n_queens_ii).
-export([totalNQueens/1]).

totalNQueens(N) ->
    solveNQueens(N, [], 0).

solveNQueens(N, Queens, Count) ->
    if length(Queens) == N ->
        Count + 1;
    true ->
        PossiblePositions = possiblePositions(N, Queens),
        lists:foldl(
            fun(Pos, Acc) ->
                solveNQueens(N, [Pos|Queens], Acc)
            end,
            Count,
            PossiblePositions
        )
    end.

possiblePositions(N, Queens) ->
    Row = length(Queens),
    lists:filter(
        fun(Col) ->
            not attack(Row, Col, Queens)
        end,
        lists:seq(0, N - 1)
    ).

attack(Row, Col, Queens) ->
    lists:any(
        fun({R, C}) ->
            R =:= Row orelse
            C =:= Col orelse
            abs(Row - R) =:= abs(Col - C)
        end,
        lists:map(
            fun(Queen) ->
                {length(Queen) - 1, lists:nth(1, Queen)}
            end,
            lists:reverse(Queens)
        )
    ).