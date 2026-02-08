-module(sum_of_square_numbers).
-export([judge_square_sum/1]).

judge_square_sum(C) ->
  judge_square_sum(C, 0).

judge_square_sum(C, A) when A * A =< C ->
  B2 = C - A * A,
  B = erlang:round(math:sqrt(B2)),
  if B * B =:= B2 ->
    true
  else
    judge_square_sum(C, A + 1)
  end;
judge_square_sum(_, _) ->
  false.