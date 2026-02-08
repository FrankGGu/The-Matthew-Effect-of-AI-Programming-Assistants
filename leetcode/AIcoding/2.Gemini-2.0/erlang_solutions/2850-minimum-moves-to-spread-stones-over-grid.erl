-module(minimum_moves_to_spread_stones).
-export([minimum_moves/1]).

minimum_moves(Grid) ->
  Stones = [],
  Empties = [],
  {Rows, Cols} = grid_size(Grid),
  lists:foreach(
    fun(Row) ->
      lists:foreach(
        fun(Col) ->
          Val = grid_get(Grid, Row, Col),
          case Val of
            0 ->
              Empties1 = [{Row, Col} | Empties];
              Empties1;
            _ when Val > 1 ->
              Stones1 = lists:flatten([lists:duplicate(Val - 1, [{Row, Col}]) | Stones]);
              Stones1;
            _ ->
              ok
          end
        end,
        lists:seq(0, Cols - 1)
      )
    end,
    lists:seq(0, Rows - 1)
  ),
  minimum_moves_helper(Stones, Empties, 0).

minimum_moves_helper([], [], Acc) ->
  Acc;
minimum_moves_helper(Stones, Empties, Acc) ->
  minimum_moves_helper_inner(Stones, Empties, 100000000000, Acc).

minimum_moves_helper_inner([], [], Min, Acc) ->
  Min + Acc;
minimum_moves_helper_inner([Stone | RestStones], Empties, Min, Acc) ->
  lists:foldl(
    fun(Empty, AccMin) ->
      {RowS, ColS} = Stone,
      {RowE, ColE} = Empty,
      Dist = abs(RowS - RowE) + abs(ColS - ColE),
      NewStones = RestStones,
      NewEmpties = lists:delete(Empty, Empties),
      NewMin = minimum_moves_helper(NewStones, NewEmpties, Acc + Dist),
      min(AccMin, NewMin)
    end,
    Min,
    Empties
  ).

grid_size(Grid) ->
  {length(Grid), length(hd(Grid))}.

grid_get(Grid, Row, Col) ->
  lists:nth(Col + 1, lists:nth(Row + 1, Grid)).