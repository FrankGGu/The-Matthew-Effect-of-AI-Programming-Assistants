-module(maximal_square).
-export([maximal_square/1]).

maximal_square(Matrix) ->
  case Matrix of
    [] ->
      0;
    [[]] ->
      0;
    _ ->
      Rows = length(Matrix),
      Cols = length(hd(Matrix)),
      DP = array:new([Rows + 1, Cols + 1], 0),
      MaxSide = maximal_square_helper(Matrix, Rows, Cols, 0, DP),
      MaxSide * MaxSide
  end.

maximal_square_helper(Matrix, Rows, Cols, MaxSide, DP) ->
  maximal_square_helper(Matrix, Rows, Cols, 1, 1, MaxSide, DP).

maximal_square_helper(Matrix, Rows, Cols, Row, Col, MaxSide, DP) ->
  case Row > Rows orelse Col > Cols of
    true ->
      MaxSide;
    false ->
      Value = lists:nth(Col, lists:nth(Row, Matrix)),
      case Value of
        "1" ->
          Up = array:get({Row - 1, Col}, DP),
          Left = array:get({Row, Col - 1}, DP),
          UpLeft = array:get({Row - 1, Col - 1}, DP),
          Side = min([Up, Left, UpLeft]) + 1,
          array:set({Row, Col}, Side, DP),
          NewMaxSide = max(MaxSide, Side),
          maximal_square_helper(Matrix, Rows, Cols, Row, Col + 1, NewMaxSide, DP);
        "0" ->
          array:set({Row, Col}, 0, DP),
          maximal_square_helper(Matrix, Rows, Cols, Row, Col + 1, MaxSide, DP)
      end
  end.