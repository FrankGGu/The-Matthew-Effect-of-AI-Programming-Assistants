-module(minimum_cost_good_caption).
-export([solve/1]).

solve(Words) ->
  N = length(Words),
  Cost = 0,
  GoodWordSet = sets:from_list(Words),

  {Cost, _} = solve_helper(Words, GoodWordSet, Cost, N).

solve_helper([], _GoodWordSet, Cost, _N) ->
  {Cost, []};

solve_helper([Word | Rest], GoodWordSet, Cost, N) ->
  case sets:is_element(Word, GoodWordSet) of
    true ->
      solve_helper(Rest, GoodWordSet, Cost, N);
    false ->
      solve_helper(Rest, GoodWordSet, Cost + N, N)
  end.