-module(solution).
-export([matrixReshape/3]).

matrixReshape(Mat, R, C) ->
    OrigR = length(Mat),
    OrigC = case Mat of
                [] -> 0;
                [H|_] -> length(H)
            end,

    TotalElements = OrigR * OrigC,

    if
        TotalElements =:= R * C ->
            Flattened = lists:flatten(Mat),
            build_matrix(Flattened, R, C, [])
    else
        Mat
    end.

build_matrix(Flattened, 0, _, Acc) ->
    lists:reverse(Acc);
build_matrix(Flattened, R, C, Acc) ->
    {CurrentRow, RestFlattened} = lists:split(C, Flattened),
    build_matrix(RestFlattened, R - 1, C, [CurrentRow | Acc]).