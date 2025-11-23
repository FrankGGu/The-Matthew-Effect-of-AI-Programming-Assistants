-module(bricks_falling_when_hit).
-export([hit_bricks/2]).

hit_bricks(Grid, Hits) ->
  {Rows, Cols} = {length(Grid), length(hd(Grid))},
  ModifiedGrid = lists:map(fun(Row) -> lists:map(fun(X) -> if X == 1 -> 1; true -> 0 end end, Row) end, Grid),

  DestroyedGrid = destroy_bricks(ModifiedGrid, Hits),

  DestroyedAndConnected = connect_bricks(DestroyedGrid, Rows, Cols),

  Result = calculate_falling(ModifiedGrid, DestroyedAndConnected, Hits),

  Result.

destroy_bricks(Grid, Hits) ->
  lists:foldl(
    fun([Row, Col], AccGrid) ->
      lists:nth(Row+1, AccGrid) ! lists:nth(Col+1, lists:nth(Row+1, AccGrid)),
      lists:nth(Row+1, AccGrid) ! lists:set_nth(Col+1, 0, lists:nth(Row+1, AccGrid)),
      AccGrid
    end,
    Grid,
    Hits
  ).

connect_bricks(Grid, Rows, Cols) ->

  % Mark connected bricks with -1
  MarkedGrid = lists:map(fun(Row) -> lists:map(fun(X) -> if X == 1 -> 1; true -> X end end, Row) end, Grid),

  % Flood fill from the top row
  FloodFilledGrid = flood_fill_top_row(MarkedGrid, Rows, Cols),

  FloodFilledGrid.

flood_fill_top_row(Grid, Rows, Cols) ->
  lists:foldl(
    fun(Col, AccGrid) ->
      if lists:nth(Col+1, hd(AccGrid)) == 1 then
        flood_fill(AccGrid, 0, Col, Rows, Cols)
      else
        AccGrid
      end
    end,
    Grid,
    lists:seq(0, Cols-1)
  ).

flood_fill(Grid, Row, Col, Rows, Cols) ->
  if Row < 0 orelse Row >= Rows orelse Col < 0 orelse Col >= Cols then
    Grid
  else
    case lists:nth(Col+1, lists:nth(Row+1, Grid)) of
      1 ->
        lists:nth(Row+1, Grid) ! lists:nth(Col+1, lists:nth(Row+1, Grid)),
        lists:nth(Row+1, Grid) ! lists:set_nth(Col+1, -1, lists:nth(Row+1, Grid)),
        NewGrid1 = flood_fill(Grid, Row - 1, Col, Rows, Cols),
        NewGrid2 = flood_fill(NewGrid1, Row + 1, Col, Rows, Cols),
        NewGrid3 = flood_fill(NewGrid2, Row, Col - 1, Rows, Cols),
        flood_fill(NewGrid3, Row, Col + 1, Rows, Cols);
      _ ->
        Grid
    end
  end.

calculate_falling(OriginalGrid, ConnectedGrid, Hits) ->
  lists:reverse(
    lists:foldl(
      fun([Row, Col], {AccGrid, Acc}) ->

        OriginalValue = lists:nth(Col+1, lists:nth(Row+1, OriginalGrid));
        ConnectedValue = lists:nth(Col+1, lists:nth(Row+1, ConnectedGrid));

        if OriginalValue == 1 and ConnectedValue == 0 then

          Neighbors = get_neighbors(AccGrid, Row, Col, length(AccGrid), length(hd(AccGrid)));

          FallingCount = lists:sum([if X == 1 -> 1; true -> 0 end || X <- Neighbors]);

          {lists:nth(Row+1, AccGrid) ! lists:nth(Col+1, lists:nth(Row+1, AccGrid)),
           lists:nth(Row+1, AccGrid) ! lists:set_nth(Col+1, 1, lists:nth(Row+1, AccGrid)),
           {AccGrid, [FallingCount|Acc]}};
        elseif OriginalValue == 1 and ConnectedValue == 1 then
            {lists:nth(Row+1, AccGrid) ! lists:nth(Col+1, lists:nth(Row+1, AccGrid)),
           lists:nth(Row+1, AccGrid) ! lists:set_nth(Col+1, 1, lists:nth(Row+1, AccGrid)),
           {AccGrid, [0|Acc]}};

        else
          {AccGrid, [0|Acc]}
        end
      end,
      {ConnectedGrid, []},
      lists:reverse(Hits)
    )
  ).

get_neighbors(Grid, Row, Col, Rows, Cols) ->
  Neighbors = [],
  Neighbors1 = if Row > 0 then [lists:nth(Col+1, lists:nth(Row, Grid))] else [],
  Neighbors2 = if Row < Rows - 1 then [lists:nth(Col+1, lists:nth(Row+2, Grid))] else [],
  Neighbors3 = if Col > 0 then [lists:nth(Col, lists:nth(Row+1, Grid))] else [],
  Neighbors4 = if Col < Cols - 1 then [lists:nth(Col+2, lists:nth(Row+1, Grid))] else [],
  Neighbors1 ++ Neighbors2 ++ Neighbors3 ++ Neighbors4.