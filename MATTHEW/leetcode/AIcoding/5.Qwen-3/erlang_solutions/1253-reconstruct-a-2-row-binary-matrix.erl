-module(reconstruct_2_row_binary_matrix).
-export([findMatrix/2]).

findMatrix(upper, lower) ->
    findMatrix(upper, lower, 0, 0, []).

findMatrix([], [], _, _, Result) ->
    lists:reverse(Result);
findMatrix([U | UTail], [L | LTail], Row1, Row2, Result) ->
    NewRow1 = Row1 + 1,
    NewRow2 = Row2 + 1,
    case (NewRow1 >= U andalso NewRow2 >= L) of
        true ->
            findMatrix(UTail, LTail, 0, 0, [[1,1] | Result]);
        false ->
            findMatrix(UTail, LTail, NewRow1, NewRow2, [[1,0] | Result])
    end.