-module(longest_increasing_path).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  Memo = array:new([{size, {Rows, Cols}}, {default, 0}]),
  lists:max([dfs(Matrix, Row, Col, Memo) || Row <- lists:seq(1, Rows), Col <- lists:seq(1, Cols)]).

dfs(Matrix, Row, Col, Memo) ->
  {Rows, Cols} = {length(Matrix), length(hd(Matrix))},
  case array:get({Row - 1, Col - 1}, Memo) of
    0 ->
      Val = lists:nth(Col, lists:nth(Row, Matrix)),
      Up = case Row > 1 of
             true ->
               UpVal = lists:nth(Col, lists:nth(Row - 1, Matrix)),
               case UpVal > Val of
                 true -> dfs(Matrix, Row - 1, Col, Memo);
                 false -> 0
               end;
             false -> 0
           end,
      Down = case Row < Rows of
               true ->
                 DownVal = lists:nth(Col, lists:nth(Row + 1, Matrix)),
                 case DownVal > Val of
                   true -> dfs(Matrix, Row + 1, Col, Memo);
                   false -> 0
                 end;
               false -> 0
             end,
      Left = case Col > 1 of
               true ->
                 LeftVal = lists:nth(Col - 1, lists:nth(Row, Matrix)),
                 case LeftVal > Val of
                   true -> dfs(Matrix, Row, Col - 1, Memo);
                   false -> 0
                 end;
               false -> 0
             end,
      Right = case Col < Cols of
                true ->
                  RightVal = lists:nth(Col + 1, lists:nth(Row, Matrix)),
                  case RightVal > Val of
                    true -> dfs(Matrix, Row, Col + 1, Memo);
                    false -> 0
                  end;
                false -> 0
              end,
      Result = 1 + lists:max([Up, Down, Left, Right]),
      array:set({Row - 1, Col - 1}, Result, Memo),
      Result;
    Value ->
      Value
  end.