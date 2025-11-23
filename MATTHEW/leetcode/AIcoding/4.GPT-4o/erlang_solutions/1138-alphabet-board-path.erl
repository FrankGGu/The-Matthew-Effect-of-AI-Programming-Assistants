-module(solution).
-export([alphabet_board_path/2]).

alphabet_board_path(Start, Target) ->
    StartPos = char_to_pos(Start),
    TargetPos = char_to_pos(Target),
    Move(StartPos, TargetPos, []).

char_to_pos(Char) ->
    {X, Y} = {rem(Char - 97, 5), div(Char - 97, 5)},
    {X, Y}.

Move({X1, Y1}, {X2, Y2}, Acc) ->
    case {X1, Y1} of
        {X2, Y2} -> lists:reverse(Acc);
        _ ->
            NewAcc = case Y1 < Y2 of
                true -> Move({X1, Y1 + 1}, {X2, Y2}, ['D' | Acc]);
                false -> Move({X1, Y1 - 1}, {X2, Y2}, ['U' | Acc])
            end,
            case X1 < X2 of
                true -> Move({X1 + 1, Y1}, {X2, Y2}, ['R' | NewAcc]);
                false -> Move({X1 - 1, Y1}, {X2, Y2}, ['L' | NewAcc])
            end
    end.