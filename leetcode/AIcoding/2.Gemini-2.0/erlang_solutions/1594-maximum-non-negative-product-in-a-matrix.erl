-module(max_non_negative_product).
-export([maximum_non_negative_product/1]).

maximum_non_negative_product(Grid) ->
  {Rows, Cols} = get_dimensions(Grid),
  Paths = find_paths(0, 0, Rows - 1, Cols - 1, Rows, Cols, Grid, []),
  MaxProduct = lists:foldl(fun(Path, Acc) ->
                                  Product = calculate_product(Path, Grid),
                                  max(Acc, Product)
                              end, -1, Paths),
  MaxProduct rem (1000000000 + 7).

get_dimensions(Grid) ->
  {length(Grid), length(hd(Grid))}.

find_paths(Row, Col, TargetRow, TargetCol, Rows, Cols, Grid, Acc) ->
  if Row == TargetRow andalso Col == TargetCol ->
    [lists:reverse([{Row, Col}] ++ Acc)];
  true ->
    NextPaths = case {Row + 1 < Rows, Col + 1 < Cols} of
                  {true, true} ->
                    find_paths(Row + 1, Col, TargetRow, TargetCol, Rows, Cols, Grid, [{Row, Col}] ++ Acc) ++
                    find_paths(Row, Col + 1, TargetRow, TargetCol, Rows, Cols, Grid, [{Row, Col}] ++ Acc);
                  {true, false} ->
                    find_paths(Row + 1, Col, TargetRow, TargetCol, Rows, Cols, Grid, [{Row, Col}] ++ Acc);
                  {false, true} ->
                    find_paths(Row, Col + 1, TargetRow, TargetCol, Rows, Cols, Grid, [{Row, Col}] ++ Acc);
                  {false, false} ->
                    []
                end,
    NextPaths
  end.

calculate_product(Path, Grid) ->
  lists:foldl(fun({Row, Col}, Acc) ->
                   Acc * lists:nth(Col + 1, lists:nth(Row + 1, Grid))
               end, 1, Path).