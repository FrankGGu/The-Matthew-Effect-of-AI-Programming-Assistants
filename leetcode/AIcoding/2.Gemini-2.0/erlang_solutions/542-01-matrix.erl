-module(zero_one_matrix).
-export([update_matrix/1]).

update_matrix(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  Dist = lists:duplicate(Rows, lists:duplicate(Cols, 100000)),

  % First pass: from top left to bottom right
  Dist1 = lists:foldl(
    fun(RowIndex, AccDist) ->
      lists:map(
        fun(ColIndex) ->
          case lists:nth(RowIndex + 1, Matrix) of
            Row when is_list(Row) ->
              case lists:nth(ColIndex + 1, Row) of
                0 -> 0;
                _ ->
                  Top = case RowIndex > 0 of
                          true -> lists:nth(ColIndex + 1, lists:nth(RowIndex, AccDist)) + 1;
                          false -> 100000
                        end,
                  Left = case ColIndex > 0 of
                           true -> lists:nth(ColIndex, lists:nth(RowIndex + 1, AccDist)) + 1;
                           false -> 100000
                         end,
                  min(Top, Left)
              end;
            _ -> 
              lists:nth(ColIndex + 1, lists:nth(RowIndex+1, AccDist)) 
          end
        end,
        lists:seq(0, Cols - 1)
      )
    end,
    Dist,
    lists:seq(0, Rows - 1)
  ),

  % Second pass: from bottom right to top left
  Dist2 = lists:foldr(
    fun(RowIndex, AccDist) ->
      lists:map(
        fun(ColIndex) ->
          case lists:nth(RowIndex + 1, Matrix) of
            Row when is_list(Row) ->
              case lists:nth(ColIndex + 1, Row) of
                0 -> 0;
                _ ->
                  Bottom = case RowIndex < Rows - 1 of
                             true -> lists:nth(ColIndex + 1, lists:nth(RowIndex + 2, AccDist)) + 1;
                             false -> 100000
                           end,
                  Right = case ColIndex < Cols - 1 of
                            true -> lists:nth(ColIndex + 2, lists:nth(RowIndex + 1, AccDist)) + 1;
                            false -> 100000
                          end,
                  OldVal = lists:nth(ColIndex + 1, lists:nth(RowIndex + 1, Dist1)),
                  min(OldVal, min(Bottom, Right))
              end;
            _ -> lists:nth(ColIndex + 1, lists:nth(RowIndex+1, AccDist))
          end
        end,
        lists:seq(0, Cols - 1)
      )
    end,
    Dist1,
    lists:seq(0, Rows - 1)
  ).