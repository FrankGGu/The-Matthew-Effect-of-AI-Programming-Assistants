-module(grid_illumination).
-export([grid_illumination/3]).

grid_illumination(N, lamps, queries) ->
  LampsSet = sets:from_list(lamps),
  {Rows, Cols, Diag1, Diag2} = process_lamps(LampsSet, N),
  lists:map(fun(Query) ->
                case is_illuminated(Query, Rows, Cols, Diag1, Diag2, LampsSet, N) of
                  true ->
                    {NewRows, NewCols, NewDiag1, NewDiag2, NewLampsSet} = extinguish_lamps(Query, Rows, Cols, Diag1, Diag2, LampsSet, N);
                    {Rows, Cols, Diag1, Diag2, LampsSet} = {NewRows, NewCols, NewDiag1, NewDiag2, NewLampsSet},
                    1;
                  false ->
                    0
                end
            end, queries).

process_lamps(LampsSet, N) ->
  lists:foldl(fun({Row, Col}, {Rows, Cols, Diag1, Diag2}) ->
                  {maps:update_with(Row, fun(X) -> X + 1 end, 1, Rows),
                   maps:update_with(Col, fun(X) -> X + 1 end, 1, Cols),
                   maps:update_with(Row - Col, fun(X) -> X + 1 end, 1, Diag1),
                   maps:update_with(Row + Col, fun(X) -> X + 1 end, 1, Diag2)}
              end, {maps:new(), maps:new(), maps:new(), maps:new()}, sets:to_list(LampsSet)).

is_illuminated({Row, Col}, Rows, Cols, Diag1, Diag2, _LampsSet, _N) ->
  (maps:get(Row, Rows, 0) > 0) orelse
    (maps:get(Col, Cols, 0) > 0) orelse
    (maps:get(Row - Col, Diag1, 0) > 0) orelse
    (maps:get(Row + Col, Diag2, 0) > 0).

extinguish_lamps({Row, Col}, Rows, Cols, Diag1, Diag2, LampsSet, N) ->
  Neighbors = [{Row - 1, Col - 1}, {Row - 1, Col}, {Row - 1, Col + 1},
               {Row, Col - 1}, {Row, Col}, {Row, Col + 1},
               {Row + 1, Col - 1}, {Row + 1, Col}, {Row + 1, Col + 1}],

  lists:foldl(fun({R, C}, {AccRows, AccCols, AccDiag1, AccDiag2, AccLampsSet}) ->
                  if R >= 0 and R < N and C >= 0 and C < N and sets:is_element({R, C}, AccLampsSet) then
                    NewRows = maps:update_with(R, fun(X) -> X - 1 end, 0, AccRows),
                    NewCols = maps:update_with(C, fun(X) -> X - 1 end, 0, AccCols),
                    NewDiag1 = maps:update_with(R - C, fun(X) -> X - 1 end, 0, AccDiag1),
                    NewDiag2 = maps:update_with(R + C, fun(X) -> X - 1 end, 0, AccDiag2),
                    NewLampsSet = sets:del_element({R, C}, AccLampsSet),
                    {NewRows, NewCols, NewDiag1, NewDiag2, NewLampsSet}
                  else
                    {AccRows, AccCols, AccDiag1, AccDiag2, AccLampsSet}
                  end
              end, {Rows, Cols, Diag1, Diag2, LampsSet}, Neighbors).