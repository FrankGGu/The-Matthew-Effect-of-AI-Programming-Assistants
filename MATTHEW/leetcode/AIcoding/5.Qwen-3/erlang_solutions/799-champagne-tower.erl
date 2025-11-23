-module(champagne_tower).
-export([pouring/2]).

pouring( poured, (Row, Col) ) ->
    pour(poured, Row, Col).

pour(0, _, _) -> 0;
pour(Poured, 0, 0) -> Poured;
pour(Poured, Row, Col) when Col > Row -> 0;
pour(Poured, Row, Col) when Col < 0 -> 0;
pour(Poured, Row, Col) ->
    Left = pour(Poured, Row - 1, Col - 1),
    Right = pour(Poured, Row - 1, Col),
    if
        Left > 1 -> Left - 1;
        true -> 0
    end + if
        Right > 1 -> Right - 1;
        true -> 0
    end.