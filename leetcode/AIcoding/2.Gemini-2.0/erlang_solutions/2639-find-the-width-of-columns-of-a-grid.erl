-module(find_width_of_columns).
-export([find_column_width/1]).

find_column_width(Grid) ->
  case Grid of
    [] -> [];
    _ ->
      NumCols = length(hd(Grid)),
      lists:map(fun(ColIndex) ->
                    lists:foldl(fun(Row, MaxWidth) ->
                                     Width = length(integer_to_list(lists:nth(ColIndex, Row))),
                                     max(Width, MaxWidth)
                                 end, 0, Grid)
                end, lists:seq(1, NumCols))
  end.