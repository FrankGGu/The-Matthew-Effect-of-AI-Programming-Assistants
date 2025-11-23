-module(solution).
-export([square_is_same_color/4]).

square_is_same_color(Row1, Col1, Row2, Col2) ->
    (Row1 + Col1) rem 2 =:= (Row2 + Col2) rem 2.