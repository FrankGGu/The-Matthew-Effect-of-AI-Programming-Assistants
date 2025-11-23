-module(solution).
-export([min_moves/2]).

min_moves(Queen, King) ->
    {Qx, Qy} = parse_position(Queen),
    {Kx, Ky} = parse_position(King),
    case {Qx - Kx, Qy - Ky} of
        {0, 0} -> 0;
        {0, Dy} when Dy =< 1, Dy >= -1 -> 1;
        {Dx, 0} when Dx =< 1, Dx >= -1 -> 1;
        {Dx, Dy} when abs(Dx) =< 1, abs(Dy) =< 1 -> 1;
        {0, _} -> 2;
        {_, 0} -> 2;
        {Dx, Dy} when abs(Dx) = abs(Dy) -> 2;
        _ -> 3
    end.

parse_position(Position) ->
    {list_to_integer(substring(Position, 1)), 
     list_to_integer(substring(Position, 2, 1))}.