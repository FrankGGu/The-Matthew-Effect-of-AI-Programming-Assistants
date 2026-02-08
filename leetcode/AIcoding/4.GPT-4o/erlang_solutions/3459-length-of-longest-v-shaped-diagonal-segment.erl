-module(solution).
-export([longest_v_shaped_diagonal/1]).

longest_v_shaped_diagonal(Matrix) ->
    case Matrix of 
        [] -> 0;
        _ -> 
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            VShape = lists:map(fun(Diag) -> v_shape_length(Matrix, Diag, Rows, Cols, 0, 0) end, lists:seq(0, Cols - 1)),
            MaxVShape = lists:max(VShape),
            MaxVShape
    end.

v_shape_length(Matrix, Diag, Rows, Cols, X, Y) ->
    case lists:splitwith(fun({X1, _}) -> X1 < X end, lists:zip(lists:seq(0, Rows - 1), lists:nth(Diag + 1, Matrix))) of
        {Above, Below} -> 
            case lists:splitwith(fun({_, Y1}) -> Y1 =< Y end, Below) of
                {V, []} -> length(Above) + length(V);
                {V, _} -> length(Above) + length(V) + 1
            end
    end.