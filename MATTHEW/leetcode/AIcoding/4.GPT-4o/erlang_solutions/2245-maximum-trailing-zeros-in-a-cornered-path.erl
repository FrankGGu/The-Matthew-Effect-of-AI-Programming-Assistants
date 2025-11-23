-module(solution).
-export([maxTrailingZeros/1]).

maxTrailingZeros(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MaxZeros = max_trailing_zeros(Matrix, Rows, Cols, 0, 0, 0),
    MaxZeros.

max_trailing_zeros(_, 0, 0, _, _, Max) -> Max;
max_trailing_zeros(Matrix, Rows, Cols, R, C, Max) ->
    case R >= Rows orelse C >= Cols of
        true -> Max;
        false ->
            NewMax = max(Max, count_trailing_zeros(Matrix, R, C)),
            max_trailing_zeros(Matrix, Rows, Cols, R + 1, C, NewMax),
            max_trailing_zeros(Matrix, Rows, Cols, R, C + 1, NewMax)
    end.

count_trailing_zeros(Matrix, R, C) ->
    Element = lists:nth(C + 1, lists:nth(R + 1, Matrix)),
    count_factors(Element, 5).

count_factors(0, _) -> 0;
count_factors(N, Factor) ->
    case N rem Factor of
        0 -> 1 + count_factors(N div Factor, Factor);
        _ -> 0
    end.