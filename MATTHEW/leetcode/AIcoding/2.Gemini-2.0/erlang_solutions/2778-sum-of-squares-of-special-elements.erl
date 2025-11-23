-module(solution).
-export([sum_of_squares/1]).

sum_of_squares(Nums) ->
  Len = length(Nums),
  sum_of_squares_helper(Nums, Len, 1, 0).

sum_of_squares_helper([], _, _, Sum) ->
  Sum;
sum_of_squares_helper([H|T], Len, Index, Sum) ->
  case Len rem Index =:= 0 of
    true ->
      sum_of_squares_helper(T, Len, Index + 1, Sum + (H * H));
    false ->
      sum_of_squares_helper(T, Len, Index + 1, Sum)
  end.