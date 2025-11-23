-module(sand_pile).
-export([sandPile/1]).

sandPile(grid) ->
  topple(grid).

topple(Grid) ->
  case unstable(Grid) of
    true ->
      NewGrid = topple_once(Grid),
      topple(NewGrid);
    false ->
      Grid
  end.

unstable(Grid) ->
  lists:any(fun(Row) ->
              lists:any(fun(X) -> X > 3 end, Row)
            end, Grid).

topple_once(Grid) ->
  {Rows, Cols} = grid_size(Grid),
  lists:map(fun(RowIndex) ->
              lists:map(fun(ColIndex) ->
                          topple_cell(Grid, RowIndex, ColIndex, Rows, Cols)
                        end, lists:seq(1, Cols))
            end, lists:seq(1, Rows)).

topple_cell(Grid, RowIndex, ColIndex, Rows, Cols) ->
  case lists:nth(ColIndex, lists:nth(RowIndex, Grid)) > 3 of
    true ->
      NewVal = lists:nth(ColIndex, lists:nth(RowIndex, Grid)) - 4,
      {Up, Down, Left, Right} = get_neighbors(RowIndex, ColIndex, Rows, Cols),
      UpVal = case Up of
                {Row, Col} -> lists:nth(Col, lists:nth(Row, Grid)) + 1;
                false -> 1
              end,
      DownVal = case Down of
                  {Row, Col} -> lists:nth(Col, lists:nth(Row, Grid)) + 1;
                  false -> 1
                end,
      LeftVal = case Left of
                  {Row, Col} -> lists:nth(Col, lists:nth(Row, Grid)) + 1;
                  false -> 1
                end,
      RightVal = case Right of
                   {Row, Col} -> lists:nth(Col, lists:nth(Row, Grid)) + 1;
                   false -> 1
                 end,

      update_neighbors(Grid, RowIndex, ColIndex, Up, Down, Left, Right, NewVal, UpVal, DownVal, LeftVal, RightVal);
    false ->
      lists:nth(ColIndex, lists:nth(RowIndex, Grid))
  end.

update_neighbors(Grid, RowIndex, ColIndex, Up, Down, Left, Right, NewVal, UpVal, DownVal, LeftVal, RightVal) ->
  lists:nth(ColIndex, lists:nth(RowIndex, Grid)) - lists:nth(ColIndex, lists:nth(RowIndex, Grid)) + NewVal.

grid_size(Grid) ->
  {length(Grid), length(hd(Grid))}.

get_neighbors(RowIndex, ColIndex, Rows, Cols) ->
  Up = case RowIndex > 1 of
         true -> {RowIndex - 1, ColIndex};
         false -> false
       end,
  Down = case RowIndex < Rows of
           true -> {RowIndex + 1, ColIndex};
           false -> false
         end,
  Left = case ColIndex > 1 of
           true -> {RowIndex, ColIndex - 1};
           false -> false
         end,
  Right = case ColIndex < Cols of
            true -> {RowIndex, ColIndex + 1};
            false -> false
          end,
  {Up, Down, Left, Right}.