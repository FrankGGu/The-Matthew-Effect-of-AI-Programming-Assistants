-module(max_students_taking_exam).
-export([max_students/1]).

max_students(Seating) ->
    Rows = length(Seating),
    Cols = length(hd(Seating)),
    Max = 0,
    All = lists:seq(0, (1 bsl Cols) - 1),
    Maps = maps:from_list([{Row, RowData} || {Row, RowData} <- lists:zip(lists:seq(0, Rows-1), Seating)]),
    find_max(All, Maps, Rows, Cols, Max).

find_max([], _Maps, _Rows, _Cols, Max) -> Max;
find_max([Mask | Rest], Maps, Rows, Cols, Max) ->
    Valid = is_valid_mask(Mask, Cols),
    if
        Valid ->
            Current = count_ones(Mask),
            if
                Current > Max ->
                    NewMax = calculate(Max, Mask, Maps, Rows, Cols);
                true ->
                    NewMax = Max
            end,
            find_max(Rest, Maps, Rows, Cols, NewMax);
        true ->
            find_max(Rest, Maps, Rows, Cols, Max)
    end.

is_valid_mask(_, 0) -> true;
is_valid_mask(Mask, Cols) ->
    case (Mask band (Mask bsl 1)) of
        0 -> true;
        _ -> false
    end.

count_ones(Mask) ->
    count_ones(Mask, 0).

count_ones(0, Count) -> Count;
count_ones(Mask, Count) ->
    count_ones(Mask bsr 1, Count + (Mask band 1)).

calculate(Max, Mask, Maps, Rows, Cols) ->
    calculate(Max, Mask, Maps, Rows, Cols, 0, 0).

calculate(Max, Mask, Maps, Rows, Cols, Row, Acc) ->
    if
        Row >= Rows ->
            max(Max, Acc);
        true ->
            RowData = maps:get(Row, Maps),
            RowMask = get_row_mask(RowData, Cols),
            if
                (Mask band RowMask) == 0 ->
                    NextAcc = Acc + count_ones(Mask band RowMask),
                    calculate(Max, Mask, Maps, Rows, Cols, Row+1, NextAcc);
                true ->
                    calculate(Max, Mask, Maps, Rows, Cols, Row+1, Acc)
            end
    end.

get_row_mask([], _) -> 0;
get_row_mask([H | T], Cols) ->
    Pos = Cols - length([H | T]),
    Bit = case H of
              1 -> 1;
              _ -> 0
          end,
    (Bit bsl Pos) + get_row_mask(T, Cols).