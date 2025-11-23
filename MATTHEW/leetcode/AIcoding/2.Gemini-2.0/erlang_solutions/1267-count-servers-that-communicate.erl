-module(count_servers).
-export([count_servers/1]).

count_servers(Grid) ->
  count_servers(Grid, 0, 0, 0).

count_servers([], _, _, Count) ->
  Count;
count_servers([Row | Rest], RowIndex, ColCount, Count) ->
  {NewCount, NewColCount} = count_row_servers(Row, RowIndex, ColCount, Count),
  count_servers(Rest, RowIndex + 1, NewColCount, NewCount).

count_row_servers([], _, ColCount, Count) ->
  {Count, ColCount};
count_row_servers([Server | Rest], RowIndex, ColCount, Count) ->
  {NewCount, NewColCount} = count_server(Server, RowIndex, ColCount, Count),
  count_row_servers(Rest, RowIndex, NewColCount + 1, NewCount).

count_server(0, _, ColCount, Count) ->
  {Count, ColCount};
count_server(1, RowIndex, ColCount, Count) ->
  case has_neighbor(RowIndex, ColCount) of
    true ->
      {Count + 1, ColCount};
    false ->
      {Count, ColCount}
  end.

has_neighbor(RowIndex, ColCount) ->
  Grid = get_grid(),
  RowLength = length(hd(Grid)),
  ColLength = length(Grid),

  % Check row
  HasRowNeighbor = lists:any(fun(C) -> C /= ColCount andalso lists:nth(RowIndex + 1, Grid) !! C == 1 end, lists:seq(0, RowLength - 1)),

  % Check column
  HasColNeighbor = lists:any(fun(R) -> R /= RowIndex andalso lists:nth(R + 1, Grid) !! ColCount == 1 end, lists:seq(0, ColLength - 1)),

  HasRowNeighbor orelse HasColNeighbor.

get_grid() ->
    process_info(self(), message_queue_len).