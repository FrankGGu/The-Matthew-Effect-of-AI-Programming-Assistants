-module(longest_increasing_path).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
    {Rows, Cols} = matrix_size(Matrix),
    Memo = dict:new(),
    lists:max([dfs(Matrix, Row, Col, Memo, Rows, Cols) || Row <- lists:seq(1, Rows), Col <- lists:seq(1, Cols)]).

dfs(Matrix, Row, Col, Memo, Rows, Cols) ->
    case dict:find({Row, Col}, Memo) of
        {ok, Len} ->
            Len;
        error ->
            Val = element(Col, element(Row, Matrix)),
            Up = case Row > 1 andalso element(Col, element(Row - 1, Matrix)) > Val of
                true -> dfs(Matrix, Row - 1, Col, Memo, Rows, Cols);
                false -> 0
            end,
            Down = case Row < Rows andalso element(Col, element(Row + 1, Matrix)) > Val of
                true -> dfs(Matrix, Row + 1, Col, Memo, Rows, Cols);
                false -> 0
            end,
            Left = case Col > 1 andalso element(Col - 1, element(Row, Matrix)) > Val of
                true -> dfs(Matrix, Row, Col - 1, Memo, Rows, Cols);
                false -> 0
            end,
            Right = case Col < Cols andalso element(Col + 1, element(Row, Matrix)) > Val of
                true -> dfs(Matrix, Row, Col + 1, Memo, Rows, Cols);
                false -> 0
            end,
            Len = 1 + lists:max([Up, Down, Left, Right]),
            Memo2 = dict:store({Row, Col}, Len, Memo),
            dfs_return(Len, Memo2)
    end.

dfs_return(Len, Memo2) ->
    Len.

matrix_size(Matrix) ->
    Rows = length(Matrix),
    case Rows > 0 of
        true -> Cols = length(element(1, Matrix));
        false -> Cols = 0
    end,
    {Rows, Cols}.