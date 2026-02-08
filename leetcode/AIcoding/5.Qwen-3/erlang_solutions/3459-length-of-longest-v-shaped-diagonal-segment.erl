-module(solution).
-export([longest_v_shaped_diagonal/1]).

longest_v_shaped_diagonal(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Matrix)),
            MaxLen = 0,
            lists:foldl(fun(I, Acc) ->
                                lists:foldl(fun(J, Acc2) ->
                                                    longest_v_shaped_diagonal_helper(Matrix, I, J, Rows, Cols, 0)
                                                end, Acc, lists:seq(0, Cols-1))
                        end, MaxLen, lists:seq(0, Rows-1)).

longest_v_shaped_diagonal_helper(_, _, _, _, _, Len) when Len < 3 -> Len;
longest_v_shaped_diagonal_helper(Matrix, I, J, Rows, Cols, Len) ->
    case {I+1 < Rows, J-1 >= 0, I+1 < Rows, J+1 < Cols} of
        {true, true, true, true} ->
            case (lists:nth(I+1, Matrix) -- [J-1]) == [lists:nth(I+1, Matrix) -- [J-1]] of
                true -> longest_v_shaped_diagonal_helper(Matrix, I+1, J-1, Rows, Cols, Len+1);
                false -> Len
            end;
        _ -> Len
    end.