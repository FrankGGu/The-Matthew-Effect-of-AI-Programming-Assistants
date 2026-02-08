-module(minimum_addition_to_make_integer_beautiful).
-export([make_beautiful/1]).

make_beautiful(N) ->
    make_beautiful(N, 1).

make_beautiful(N, Power) ->
    Div = math:pow(10, Power),
    Remainder = N rem Div,
    if
        Remainder == 0 ->
            0;
        true ->
            Next = Div - Remainder + N,
            Next - N
    end.