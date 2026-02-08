-module(min_path_sum).
-export([min_path_sum/1]).

min_path_sum(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  dp(Grid, Rows, Cols).

dp(Grid, Rows, Cols) ->
  DP = array:new([Rows, Cols]),
  array:set(DP, {0, 0}, lists:nth(1, lists:nth(1, Grid))),

  lists:foreach(fun(Row) ->
                  ColIdx = Row - 1,
                  Val = array:get(DP, {ColIdx, 0}) + lists:nth(1, lists:nth(Row, Grid)),
                  array:set(DP, {ColIdx, 0}, Val)
                end, lists:seq(2, Rows)),

  lists:foreach(fun(Col) ->
                  ColIdx = Col - 1,
                  Val = array:get(DP, {0, ColIdx}) + lists:nth(Col, hd(Grid)),
                  array:set(DP, {0, ColIdx}, Val)
                end, lists:seq(2, Cols)),

  lists:foreach(fun(Row) ->
                  lists:foreach(fun(Col) ->
                                  if
                                    Row == 1 and Col == 1 ->
                                      ok;
                                    true ->
                                      Val = lists:nth(Col, lists:nth(Row, Grid)),
                                      Up = array:get(DP, {Row - 2, Col - 1}),
                                      Left = array:get(DP, {Row - 1, Col - 2}),
                                      MinVal = min(Up, Left) + Val,
                                      array:set(DP, {Row - 1, Col - 1}, MinVal)
                                  end
                                end, lists:seq(2, Cols))
                end, lists:seq(2, Rows)),

  array:get(DP, {Rows - 1, Cols - 1}).