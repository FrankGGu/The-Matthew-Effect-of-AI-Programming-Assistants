-module(reversi).
-export([make_move/4]).

get_board_value(Board, R, C) when R >= 0, R < 8, C >= 0, C < 8 ->
    lists:nth(C + 1, lists:nth(R + 1, Board));
get_board_value(_Board, _R, _C) ->
    undefined.

set_board_value(Board, R, C, Value) when R >= 0, R < 8, C >= 0, C < 8 ->
    lists:replace_at(R + 1, lists:replace_at(C + 1, Value, lists:nth(R + 1, Board)), Board);
set_board_value(Board, _R, _C, _Value) ->
    Board.

-define(DIRECTIONS, [{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]).

make_move(Board, R, C, Player) when R >= 0, R < 8, C >= 0, C < 8 ->
    Opponent = case Player of 'b' -> 'w'; 'w' -> 'b' end,

    case get_board_value(Board, R, C) of
        '.' ->
            {FlippedBoard, FlippedCount} = lists:foldl(
                fun({DR, DC}, {AccBoard, AccCount}) ->
                    flip_direction(AccBoard, R, C, Player, Opponent, DR, DC, AccCount)
                end,
                {Board, 0},
                ?DIRECTIONS
            ),

            if FlippedCount > 0 ->
                {ok, set_board_value(FlippedBoard, R, C, Player)};
            true ->
                {error, invalid_move}
            end;
        _ ->
            {error, invalid_move}
    end;
make_move(_Board, _R, _C, _Player) ->
    {error, invalid_move}.

flip_direction(Board, R, C, Player, Opponent, DR, DC, CurrentFlippedCount) ->
    Path = find_path_to_flip(Board, R, C, Player, Opponent, DR, DC, []),
    case Path of
        [] -> {Board, CurrentFlippedCount};
        _ ->
            NewBoard = lists:foldl(
                fun({FlipR, FlipC}, AccBoard) ->
                    set_board_value(AccBoard, FlipR, FlipC, Player)
                end,
                Board,
                Path
            ),
            {NewBoard, CurrentFlippedCount + length(Path)}
    end.

find_path_to_flip(Board, R, C, Player, Opponent, DR, DC, CurrentPath) ->
    NextR = R + DR,
    NextC = C + DC,

    case get_board_value(Board, NextR, NextC) of
        Opponent ->
            find_path_to_flip(Board, NextR, NextC, Player, Opponent, DR, DC, [{NextR, NextC} | CurrentPath]);
        Player ->
            CurrentPath;
        _ ->
            []
    end.