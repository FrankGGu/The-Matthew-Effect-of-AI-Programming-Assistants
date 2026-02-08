-module(min_area_rect).
-export([min_area_rect/1]).

min_area_rect(image) ->
    Rows = length(image),
    Cols = length(hd(image)),
    Ones = find_ones(image, Rows, Cols, []),
    case length(Ones) < 2 of
        true -> 0;
        false ->
            min_area(Ones, Rows, Cols)
    end.

find_ones(Image, Rows, Cols, Acc) ->
    find_ones_helper(Image, Rows, Cols, 0, 0, Acc).

find_ones_helper(_, Rows, _, Row, _, Acc) when Row >= Rows ->
    lists:reverse(Acc);
find_ones_helper(Image, Rows, Cols, Row, Col, Acc) when Col >= Cols ->
    find_ones_helper(Image, Rows, Cols, Row + 1, 0, Acc);
find_ones_helper(Image, Rows, Cols, Row, Col, Acc) ->
    case lists:nth(Row + 1, Image) of
        RowList ->
            case lists:nth(Col + 1, RowList) of
                1 ->
                    find_ones_helper(Image, Rows, Cols, Row, Col + 1, [{Row, Col} | Acc]);
                _ ->
                    find_ones_helper(Image, Rows, Cols, Row, Col + 1, Acc)
            end
    end.

min_area(Ones, Rows, Cols) ->
    min_area_helper(Ones, Rows, Cols, infinity).

min_area_helper([], _, _, MinArea) ->
    MinArea;
min_area_helper([One | Rest], Rows, Cols, MinArea) ->
    min_area_helper2(One, Rest, Rows, Cols, MinArea).

min_area_helper2(_, [], _, _, MinArea) ->
    MinArea;
min_area_helper2(One, [Other | Rest], Rows, Cols, MinArea) ->
    {Row1, Col1} = One,
    {Row2, Col2} = Other,
    PossibleOnes = [O || O <- Rest, is_possible(One, Other, O)],
    NewMinArea = find_min_area(One, Other, PossibleOnes, Rows, Cols, MinArea),
    min_area_helper2(One, Rest, Rows, Cols, NewMinArea).

is_possible({Row1, Col1}, {Row2, Col2}, {Row3, Col3}) ->
    Row1 =< Row3 and Row3 =< Row2 and Col1 =< Col3 and Col3 =< Col2.

find_min_area(One, Other, PossibleOnes, Rows, Cols, MinArea) ->
    {Row1, Col1} = One,
    {Row2, Col2} = Other,
    AllOnes = [One, Other | PossibleOnes],
    MinRow = min_row(AllOnes),
    MaxRow = max_row(AllOnes),
    MinCol = min_col(AllOnes),
    MaxCol = max_col(AllOnes),
    Area = (MaxRow - MinRow + 1) * (MaxCol - MinCol + 1),
    Covered = is_covered(AllOnes, MinRow, MaxRow, MinCol, MaxCol),

    case Covered of
        true ->
            case Area < MinArea of
                true -> Area;
                false -> MinArea
            end;
        false ->
            MinArea
    end.

min_row(Ones) ->
    lists:min([Row || {Row, _} <- Ones]).

max_row(Ones) ->
    lists:max([Row || {Row, _} <- Ones]).

min_col(Ones) ->
    lists:min([Col || {_, Col} <- Ones]).

max_col(Ones) ->
    lists:max([Col || {_, Col} <- Ones]).

is_covered(AllOnes, MinRow, MaxRow, MinCol, MaxCol) ->
    lists:all(fun({Row, Col}) ->
                      Row >= MinRow and Row =< MaxRow and Col >= MinCol and Col =< MaxCol
              end, AllOnes).

infinity() ->
    1 bsl 63 - 1.