-module(magic_chessboard).
-export([magic_chessboard/1]).

magic_chessboard(N) when N rem 2 == 1 ->
    {error, "N must be even"};
magic_chessboard(N) ->
    Board = lists:map(fun(_) -> lists:duplicate(N, 0) end, lists:seq(1, N)),
    {Rows, Cols} = fill_chessboard(Board, N, 1, 1, 1, 1),
    {Rows, Cols}.

fill_chessboard(Board, N, R, C, Count, Direction) when Count =< N*N ->
    NewBoard = lists:map(fun (Row, R) -> if R rem 2 == 0 -> Row end ++ [Count] end, Board),
    case Direction of
        1 -> fill_chessboard(NewBoard, N, R, C + 1, Count + 1, 1);
        2 -> fill_chessboard(NewBoard, N, R + 1, C, Count + 1, 1);
        3 -> fill_chessboard(NewBoard, N, R, C - 1, Count + 1, 2);
        4 -> fill_chessboard(NewBoard, N, R - 1, C, Count + 1, 2)
    end;
fill_chessboard(Board, N, R, C, Count, _) ->
    {R, C}.