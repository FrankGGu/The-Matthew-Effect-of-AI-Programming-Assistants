-module(max_energy).
-export([solve/1]).

solve(dungeon) ->
  Rows = length(dungeon),
  Cols = length(hd(dungeon)),
  dp(Rows, Cols, dungeon).

dp(Rows, Cols, Dungeon) ->
  DP = array:new([Rows, Cols], -1),

  % Initialize the bottom right cell
  array:set([Rows - 1, Cols - 1], max(1, lists:nth(Cols - 1, lists:nth(Rows - 1, Dungeon))), DP1 = DP),

  % Initialize the last row
  DP2 = init_last_row(Rows, Cols, Dungeon, DP1),

  % Initialize the last column
  DP3 = init_last_col(Rows, Cols, Dungeon, DP2),

  % Fill in the rest of the DP table
  DP4 = fill_dp(Rows, Cols, Dungeon, DP3),

  array:get([0, 0], DP4).

init_last_row(Rows, Cols, Dungeon, DP) ->
  lists:foldl(
    fun(Col, Acc) ->
      if Col < Cols - 1 then
        Prev = array:get([Rows - 1, Col + 1], Acc),
        Val = lists:nth(Col, lists:nth(Rows - 1, Dungeon)),
        array:set([Rows - 1, Col], max(1, Prev + Val), Acc)
      else
        Acc
      end
    end,
    DP,
    lists:seq(0, Cols - 2)
  ).

init_last_col(Rows, Cols, Dungeon, DP) ->
  lists:foldl(
    fun(Row, Acc) ->
      if Row < Rows - 1 then
        Prev = array:get([Row + 1, Cols - 1], Acc),
        Val = lists:nth(Cols - 1, lists:nth(Row, Dungeon)),
        array:set([Row, Cols - 1], max(1, Prev + Val), Acc)
      else
        Acc
      end
    end,
    DP,
    lists:seq(0, Rows - 2)
  ).

fill_dp(Rows, Cols, Dungeon, DP) ->
  lists:foldl(
    fun(Row, Acc) ->
      lists:foldl(
        fun(Col, Acc2) ->
          if Row < Rows - 1 andalso Col < Cols - 1 then
            Down = array:get([Row + 1, Col], Acc2),
            Right = array:get([Row, Col + 1], Acc2),
            Val = lists:nth(Col, lists:nth(Row, Dungeon)),
            array:set([Row, Col], max(1, max(Down, Right) + Val), Acc2)
          else
            Acc2
          end
        end,
        Acc,
        lists:seq(0, Cols - 2)
      )
    end,
    DP,
    lists:seq(0, Rows - 2)
  ).