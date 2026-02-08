-module(maximum_score).
-export([max_score/1]).

max_score(Grid) ->
  {Rows, Cols} = grid_size(Grid),
  memo(Grid, Rows - 1, Cols - 1, {}).

grid_size(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  {Rows, Cols}.

memo(Grid, Row, Col, Memo) ->
  case maps:get({Row, Col}, Memo, undefined) of
    undefined ->
      Value = lists:nth(Row + 1, lists:nth(Col + 1, Grid)),
      case {Row, Col} of
        {0, 0} ->
          maps:put({Row, Col}, Value, Memo);
        _ ->
          Score1 = case Row > 0 of
                     true ->
                       memo(Grid, Row - 1, Col, Memo) + Value;
                     false ->
                       -1
                   end,
          Score2 = case Col > 0 of
                     true ->
                       memo(Grid, Row, Col - 1, Memo) + Value;
                     false ->
                       -1
                   end,
          MaxScore = max(Score1, Score2),
          maps:put({Row, Col}, MaxScore, Memo)
      end,
      maps:get({Row, Col}, Memo);
    Score ->
      Score
  end.