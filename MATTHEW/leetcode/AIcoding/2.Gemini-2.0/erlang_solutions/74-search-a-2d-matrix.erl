-module(search_matrix).
-export([search_matrix/2]).

search_matrix(Matrix, Target) ->
  search_matrix(Matrix, Target, 0, length(Matrix) - 1).

search_matrix(Matrix, Target, RowStart, RowEnd) ->
  case RowStart > RowEnd of
    true ->
      false;
    false ->
      RowMid = (RowStart + RowEnd) div 2,
      Row = lists:nth(RowMid + 1, Matrix),
      case Target >= hd(Row) andalso Target =< lists:last(Row) of
        true ->
          lists:member(Target, Row);
        false ->
          case Target < hd(Row) of
            true ->
              search_matrix(Matrix, Target, RowStart, RowMid - 1);
            false ->
              search_matrix(Matrix, Target, RowMid + 1, RowEnd)
          end
      end
  end.