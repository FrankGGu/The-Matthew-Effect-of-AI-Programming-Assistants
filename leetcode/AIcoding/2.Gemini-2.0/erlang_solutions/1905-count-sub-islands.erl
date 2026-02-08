-module(count_sub_islands).
-export([num_sub_islands/2]).

num_sub_islands(Grid1, Grid2) ->
  {Rows, Cols} = grid_size(Grid1),
  Visited = array:new([Rows, Cols], {fixed, 0}),
  count_sub_islands_helper(Grid1, Grid2, 0, Visited, Rows, Cols).

count_sub_islands_helper(Grid1, Grid2, Count, Visited, Rows, Cols) ->
  count_sub_islands_helper(Grid1, Grid2, Count, Visited, 0, 0, Rows, Cols).

count_sub_islands_helper(Grid1, Grid2, Count, Visited, Rows, Cols, MaxRows, MaxCols) ->
  case {Rows >= MaxRows} of
    true ->
      Count;
    false ->
      case {Cols >= MaxCols} of
        true ->
          count_sub_islands_helper(Grid1, Grid2, Count, Visited, Rows + 1, 0, MaxRows, MaxCols);
        false ->
          case {get_grid(Grid2, Rows, Cols) == 1, array:get({Rows, Cols}, Visited) == 0} of
            {true, true} ->
              IsSubIsland = is_sub_island(Grid1, Grid2, Rows, Cols, Visited, MaxRows, MaxCols),
              NewCount = case IsSubIsland of
                           true -> Count + 1;
                           false -> Count
                         end,
              count_sub_islands_helper(Grid1, Grid2, NewCount, Visited, Rows, Cols + 1, MaxRows, MaxCols);
            _ ->
              count_sub_islands_helper(Grid1, Grid2, Count, Visited, Rows, Cols + 1, MaxRows, MaxCols)
          end
      end
  end.

is_sub_island(Grid1, Grid2, Row, Col, Visited, MaxRows, MaxCols) ->
  is_sub_island_helper(Grid1, Grid2, Row, Col, Visited, MaxRows, MaxCols, true).

is_sub_island_helper(Grid1, Grid2, Row, Col, Visited, MaxRows, MaxCols, IsSubIsland) ->
  case {Row < 0 orelse Row >= MaxRows orelse Col < 0 orelse Col >= MaxCols} of
    true ->
      IsSubIsland;
    false ->
      case {array:get({Row, Col}, Visited) == 0, get_grid(Grid2, Row, Col) == 1} of
        {true, true} ->
          IsSub = IsSubIsland and (get_grid(Grid1, Row, Col) == 1),
          array:set({Row, Col}, 1, Visited),
          IsSub1 = is_sub_island_helper(Grid1, Grid2, Row + 1, Col, Visited, MaxRows, MaxCols, IsSub),
          IsSub2 = is_sub_island_helper(Grid1, Grid2, Row - 1, Col, Visited, MaxRows, MaxCols, IsSub1),
          IsSub3 = is_sub_island_helper(Grid1, Grid2, Row, Col + 1, Visited, MaxRows, MaxCols, IsSub2),
          is_sub_island_helper(Grid1, Grid2, Row, Col - 1, Visited, MaxRows, MaxCols, IsSub3);
        _ ->
          IsSubIsland
      end
  end.

grid_size(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  {Rows, Cols}.

get_grid(Grid, Row, Col) ->
  lists:nth(Col + 1, lists:nth(Row + 1, Grid)).