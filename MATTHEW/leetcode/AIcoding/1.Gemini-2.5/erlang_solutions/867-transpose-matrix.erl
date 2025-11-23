-module(solution).
-export([transpose/1]).

transpose(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),

    [ [ lists:nth(CIndex + 1, lists:nth(RIndex + 1, Matrix)) || RIndex <- lists:seq(0, Rows - 1) ] || CIndex <- lists:seq(0, Cols - 1) ].