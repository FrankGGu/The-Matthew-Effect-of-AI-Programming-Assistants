-module(min_flips).
-export([minFlips/1]).

minFlips(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    State = to_state(Matrix, 0, 0, 0),
    solve(State, Rows, Cols).

to_state([], _, _, Acc) -> Acc;
to_state([Row|Rest], R, C, Acc) ->
    to_state(Rest, R+1, 0, to_state_row(Row, R, C, Acc)).

to_state_row([], _, _, Acc) -> Acc;
to_state_row([B|Rest], R, C, Acc) ->
    Bit = case B of
              0 -> 0;
              _ -> 1
          end,
    to_state_row(Rest, R, C+1, Acc + (Bit bsl (R * 16 + C))).

solve(State, Rows, Cols) ->
    solve(State, 0, 0, 0, Rows, Cols).

solve(State, R, C, Flips, Rows, Cols) ->
    if
        R >= Rows -> Flips;
        true ->
            NextC = C + 1,
            NextR = if NextC > Cols - 1 -> R + 1; true -> R end,
            NewC = if NextC > Cols - 1 -> 0; true -> NextC end,
            CurrentBit = (State bsr (R * 16 + C)) band 1,
            if
                CurrentBit == 1 ->
                    FlipState = flip(State, R, C, Rows, Cols),
                    solve(FlipState, NextR, NewC, Flips + 1, Rows, Cols);
                true ->
                    solve(State, NextR, NewC, Flips, Rows, Cols)
            end
    end.

flip(State, R, C, Rows, Cols) ->
    flip_cell(State, R, C),
    if
        R + 1 < Rows -> flip_cell(State, R + 1, C);
        true -> State
    end,
    if
        R - 1 >= 0 -> flip_cell(State, R - 1, C);
        true -> State
    end,
    if
        C + 1 < Cols -> flip_cell(State, R, C + 1);
        true -> State
    end,
    if
        C - 1 >= 0 -> flip_cell(State, R, C - 1);
        true -> State
    end.

flip_cell(State, R, C) ->
    Pos = R * 16 + C,
    State bxor (1 bsl Pos).