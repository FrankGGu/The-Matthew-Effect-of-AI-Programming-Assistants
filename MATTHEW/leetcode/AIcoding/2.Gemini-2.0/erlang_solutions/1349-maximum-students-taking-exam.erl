-module(maximum_students).
-export([max_students/1]).

max_students(Seats) ->
    Rows = length(Seats),
    Cols = length(hd(Seats)),
    dp(Rows, Cols, Seats, 0, 0, #{}).

dp(0, _Cols, _Seats, Mask, Count, Memo) ->
    {Mask, Count} = {Mask, Count}, % Suppress unused variable warning
    Count;
dp(Row, Cols, Seats, Mask, Count, Memo) ->
    case maps:get({Row, Mask}, Memo, undefined) of
        undefined ->
            RowIndex = Row - 1,
            RowSeats = lists:nth(RowIndex + 1, Seats),
            Max = solve_row(RowSeats, Cols, 0, 0, Mask, Seats, RowIndex, Memo),
            Result = dp(Row - 1, Cols, Seats, 0, Count + Max, Memo),
            maps:put({Row, Mask}, Result, Memo),
            Result;
        Result ->
            Result
    end.

solve_row(_RowSeats, 0, _CurrentMask, Count, _PrevMask, _Seats, _RowIndex, _Memo) ->
    Count;
solve_row(RowSeats, Col, CurrentMask, Count, PrevMask, Seats, RowIndex, Memo) ->
    ColIndex = Col - 1,
    case lists:nth(ColIndex + 1, RowSeats) of
        '.' ->
            % Try placing a student
            NewMask = CurrentMask bor (1 bsl ColIndex),
            Safe = is_safe(NewMask, ColIndex, PrevMask, length(hd(Seats))),
            case Safe of
                true ->
                    Count1 = solve_row(RowSeats, Col - 1, NewMask, Count + 1, PrevMask, Seats, RowIndex, Memo);
                false ->
                    Count1 = 0 % Prevent from being selected
            end,

            % Try not placing a student
            Count2 = solve_row(RowSeats, Col - 1, CurrentMask, Count, PrevMask, Seats, RowIndex, Memo),

            max(Count1, Count2);
        '*' ->
            solve_row(RowSeats, Col - 1, CurrentMask, Count, PrevMask, Seats, RowIndex, Memo)
    end.

is_safe(Mask, ColIndex, PrevMask, Cols) ->
    LeftSafe = ColIndex == 0 orelse (Mask band (1 bsl (ColIndex - 1))) == 0,
    RightSafe = ColIndex == (Cols - 1) orelse (Mask band (1 bsl (ColIndex + 1))) == 0,
    UpLeftSafe = (PrevMask band (1 bsl (ColIndex - 1))) == 0,
    UpRightSafe = (PrevMask band (1 bsl (ColIndex + 1))) == 0,

    LeftSafe and RightSafe and UpLeftSafe and UpRightSafe.