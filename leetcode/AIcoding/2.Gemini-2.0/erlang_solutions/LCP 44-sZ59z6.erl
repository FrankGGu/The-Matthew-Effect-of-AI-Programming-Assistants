-module(solution).
-export([solve/1]).

-spec solve([integer()]) -> integer().
solve(A) ->
  solve_helper(A, []).

solve_helper([], Acc) ->
  length(Acc);
solve_helper([H|T], Acc) ->
  case lists:member(H, Acc) of
    true ->
      solve_helper(T, Acc);
    false ->
      solve_helper(T, [H|Acc])
  end.