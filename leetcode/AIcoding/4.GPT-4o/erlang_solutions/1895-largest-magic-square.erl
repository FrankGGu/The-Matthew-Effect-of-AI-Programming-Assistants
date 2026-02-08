-module(largest_magic_square).
-export([largest_magic_square/1]).

largest_magic_square(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MaxSize = min(Rows, Cols),
    lists:foldl(fun(Size, Acc) ->
        case find_largest_magic_square(Matrix, Rows, Cols, Size) of
            {ok, {X, Y}} -> Size;
            _ -> Acc
        end
    end, 0, lists:seq(1, MaxSize)).

find_largest_magic_square(Matrix, Rows, Cols, Size) ->
    lists:foldl(fun(Row, Acc) ->
        case lists:foldl(fun(Col, Acc2) ->
            case is_magic_square(Matrix, Row, Col, Size) of
                true -> {ok, {Row, Col}};
                false -> Acc2
            end
        end, Acc, lists:seq(0, Cols - Size)) of
            {ok, _} = Result -> Result;
            _ -> Acc
        end
    end, error, lists:seq(0, Rows - Size)).

is_magic_square(Matrix, Row, Col, Size) ->
    Sum = lists:sum(lists:sublist(Matrix, Row, Size)),
    RowSums = lists:map(fun(R) -> lists:sum(lists:sublist(Matrix, R, Size)) end, lists:seq(Row, Row + Size - 1)),
    ColSums = lists:map(fun(C) -> lists:sum(lists:map(fun(R) -> lists:nth(C + 1, lists:nth(R + 1, Matrix)) end, lists:seq(Row, Row + Size - 1))) end, lists:seq(0, Size - 1)),
    Diag1Sum = lists:sum(lists:map(fun(I) -> lists:nth(Row + I + 1, lists:nth(Col + I + 1, Matrix)) end, lists:seq(0, Size - 1))),
    Diag2Sum = lists:sum(lists:map(fun(I) -> lists:nth(Row + I + 1, lists:nth(Col + Size - I, Matrix)) end, lists:seq(0, Size - 1))),
    lists:all(fun(X) -> X =:= Sum end, RowSums) andalso
    lists:all(fun(X) -> X =:= Sum end, ColSums) andalso
    Diag1Sum =:= Sum andalso
    Diag2Sum =:= Sum.