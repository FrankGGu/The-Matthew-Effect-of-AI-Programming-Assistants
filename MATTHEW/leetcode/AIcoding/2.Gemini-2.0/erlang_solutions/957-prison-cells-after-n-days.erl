-module(prison_cells).
-export([prison_after_n_days/2]).

prison_after_n_days(Cells, N) ->
  prison_after_n_days(Cells, N, [], []).

prison_after_n_days(Cells, 0, _, _) ->
  Cells;
prison_after_n_days(Cells, N, Seen, Results) ->
  Next_cells = next_day(Cells),
  case lists:member(Next_cells, Seen) of
    true ->
      First_index = lists:keyfind(Next_cells, 1, lists:zip(Seen,Results)),
      {Next_cells,Index} = First_index,
      Cycle_length = length(Seen) - Index + 1,
      Final_index = (N - 1 - Index) rem Cycle_length + Index ,
      lists:nth(Final_index + 1, Results);
    false ->
      prison_after_n_days(Next_cells, N - 1, Seen ++ [Next_cells], Results ++ [Next_cells])
  end.

next_day(Cells) ->
  [next_cell(Cells, I) || I <- lists:seq(1, length(Cells))].

next_cell(Cells, 1) ->
  0;
next_cell(Cells, N) when N == length(Cells) ->
  0;
next_cell(Cells, I) ->
  case lists:nth(I - 1, Cells) =:= lists:nth(I + 1, Cells) of
    true -> 1;
    false -> 0
  end.