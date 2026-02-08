-module(solution).
-export([max_students/1]).

max_students(Seats) ->
    Rows = length(Seats),
    Cols = case Rows of 0 -> 0; _ -> length(hd(Seats)) end,
    DP = maps:new(),
    {Ans, _} = dfs(Seats, 0, 0, 0, DP, Rows, Cols),
    Ans.

dfs(Seats, Row, Mask, Count, DP, Rows, Cols) when Row >= Rows ->
    {Count, DP};
dfs(Seats, Row, PrevMask, Count, DP, Rows, Cols) ->
    Key = {Row, PrevMask},
    case maps:find(Key, DP) of
        {ok, {C, NewDP}} -> {C, NewDP};
        error ->
            Max = 0,
            {NewMax, NewDP} = generate_masks(Seats, Row, 0, PrevMask, Count, DP, Rows, Cols, 0, 0),
            {NewMax, maps:put(Key, {NewMax, NewDP}, NewDP)}
    end.

generate_masks(Seats, Row, Col, PrevMask, Count, DP, Rows, Cols, CurrentMask, Max) when Col >= Cols ->
    NextRow = Row + 1,
    case is_valid(Seats, Row, CurrentMask, Rows, Cols) of
        true ->
            NewCount = Count + count_bits(CurrentMask),
            dfs(Seats, NextRow, CurrentMask, NewCount, DP, Rows, Cols);
        false ->
            {Max, DP}
    end;
generate_masks(Seats, Row, Col, PrevMask, Count, DP, Rows, Cols, CurrentMask, Max) ->
    Seat = lists:nth(Col + 1, lists:nth(Row + 1, Seats)),
    case Seat of
        $. ->
            NewMask = CurrentMask bor (1 bsl Col),
            CanPlace = (Col =:= 0 orelse (PrevMask band (1 bsl (Col - 1))) =:= 0) andalso
                       (Col =:= 0 orelse (NewMask band (1 bsl (Col - 1))) =:= 0) andalso
                       (Col =:= Cols - 1 orelse (PrevMask band (1 bsl (Col + 1))) =:= 0) andalso
                       (Col =:= Cols - 1 orelse (NewMask band (1 bsl (Col + 1))) =:= 0),
            {NewMax1, NewDP1} = generate_masks(Seats, Row, Col + 1, PrevMask, Count, DP, Rows, Cols, CurrentMask, Max),
            case CanPlace of
                true ->
                    {NewMax2, NewDP2} = generate_masks(Seats, Row, Col + 1, PrevMask, Count, DP, Rows, Cols, NewMask, Max),
                    if NewMax2 > NewMax1 -> {NewMax2, NewDP2}; true -> {NewMax1, NewDP1} end;
                false ->
                    {NewMax1, NewDP1}
            end;
        _ ->
            generate_masks(Seats, Row, Col + 1, PrevMask, Count, DP, Rows, Cols, CurrentMask, Max)
    end.

is_valid(Seats, Row, Mask, Rows, Cols) ->
    Valid = true,
    check_cols(Seats, Row, Mask, 0, Cols, Valid).

check_cols(_, _, _, Col, Cols, Valid) when Col >= Cols ->
    Valid;
check_cols(Seats, Row, Mask, Col, Cols, Valid) ->
    case (Mask band (1 bsl Col)) =/= 0 of
        true ->
            Seat = lists:nth(Col + 1, lists:nth(Row + 1, Seats)),
            case Seat of
                $. ->
                    LeftOk = Col =:= 0 orelse (Mask band (1 bsl (Col - 1))) =:= 0,
                    RightOk = Col =:= Cols - 1 orelse (Mask band (1 bsl (Col + 1))) =:= 0,
                    check_cols(Seats, Row, Mask, Col + 1, Cols, Valid and LeftOk and RightOk);
                _ ->
                    false
            end;
        false ->
            check_cols(Seats, Row, Mask, Col + 1, Cols, Valid)
    end.

count_bits(Mask) ->
    count_bits(Mask, 0).

count_bits(0, Count) ->
    Count;
count_bits(Mask, Count) ->
    count_bits(Mask band (Mask - 1), Count + 1).