-module(longest_increasing_path).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  Memo = array:new([Rows, Cols], -1),
  lists:max([dfs(Matrix, Row, Col, Memo, Rows, Cols) || Row <- lists:seq(0, Rows - 1), Col <- lists:seq(0, Cols - 1)]).

dfs(Matrix, Row, Col, Memo, Rows, Cols) ->
  case array:get([Row, Col], Memo) of
    -1 ->
      Val = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
      Up = case Row > 0 andalso lists:nth(Col + 1, lists:nth(Row, Matrix)) > Val of
        true -> dfs(Matrix, Row - 1, Col, Memo, Rows, Cols);
        false -> 0
      end,
      Down = case Row < Rows - 1 andalso lists:nth(Col + 1, lists:nth(Row + 2, Matrix)) > Val of
        true -> dfs(Matrix, Row + 1, Col, Memo, Rows, Cols);
        false -> 0
      end,
      Left = case Col > 0 andalso lists:nth(Col, lists:nth(Row + 1, Matrix)) > Val of
        true -> dfs(Matrix, Row, Col - 1, Memo, Rows, Cols);
        false -> 0
      end,
      Right = case Col < Cols - 1 andalso lists:nth(Col + 2, lists:nth(Row + 1, Matrix)) > Val of
        true -> dfs(Matrix, Row, Col + 1, Memo, Rows, Cols);
        false -> 0
      end,
      Result = 1 + lists:max([Up, Down, Left, Right]),
      array:set([Row, Col], Result, Memo),
      Result;
    Value ->
      Value
  end.