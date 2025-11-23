-module(min_flips).
-export([min_flips/1]).

min_flips(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  Start = list_to_integer([integer_to_list(X) || Row <- Matrix, X <- Row]),
  Target = 0,
  Q = queue:new(),
  Q1 = queue:in({Start, 0}, Q),
  Visited = sets:new(),
  min_flips_helper(Q1, Target, Rows, Cols, sets:add_element(Start, Visited)).

min_flips_helper(Q, Target, Rows, Cols, Visited) ->
  case queue:is_empty(Q) of
    true -> -1;
    false ->
      {{value, {Curr, Steps}}, Q1} = queue:out(Q),
      if Curr == Target ->
        Steps
      else
        Neighbors = get_neighbors(Curr, Rows, Cols),
        Q2 = lists:foldl(
               fun(Neighbor, AccQ) ->
                 case sets:is_element(Neighbor, Visited) of
                   true ->
                     AccQ;
                   false ->
                     queue:in({Neighbor, Steps + 1}, AccQ)
                 end
               end,
               Q1,
               Neighbors
              ),
        min_flips_helper(Q2, Target, Rows, Cols, sets:add_element(Curr, Visited))
      end
  end.

get_neighbors(Curr, Rows, Cols) ->
  lists:flatten([
    [flip(Curr, I, Rows, Cols) || I <- lists:seq(0, Rows * Cols - 1)]
  ]).

flip(Curr, I, Rows, Cols) ->
  Row = I div Cols,
  Col = I rem Cols,
  Flipped = bitwise:bxor(Curr, (1 bsl I)),
  Flipped1 = case Row > 0 of
    true ->
      bitwise:bxor(Flipped, (1 bsl ((Row - 1) * Cols + Col)));
    false ->
      Flipped
  end,
  Flipped2 = case Row < Rows - 1 of
    true ->
      bitwise:bxor(Flipped1, (1 bsl ((Row + 1) * Cols + Col)));
    false ->
      Flipped1
  end,
  Flipped3 = case Col > 0 of
    true ->
      bitwise:bxor(Flipped2, (1 bsl (Row * Cols + (Col - 1))));
    false ->
      Flipped2
  end,
  case Col < Cols - 1 of
    true ->
      bitwise:bxor(Flipped3, (1 bsl (Row * Cols + (Col + 1))));
    false ->
      Flipped3
  end.