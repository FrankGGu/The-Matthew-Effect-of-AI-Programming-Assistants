-module(solution).
-export([square_is_white/1]).

square_is_white(Square) ->
    {X, Y} = parse_square(Square),
    (X rem 2) =:= (Y rem 2).

parse_square(Square) ->
    X = element(1, string:to_integer(Square)),
    Y = element(2, string:to_integer(Square)),
    {X, Y}.