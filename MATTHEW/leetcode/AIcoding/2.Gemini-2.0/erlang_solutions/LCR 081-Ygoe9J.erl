-module(combination_sum).
-export([combination_sum/2]).

combination_sum(Candidates, Target) ->
  combination_sum_helper(Candidates, Target, [], []).

combination_sum_helper(Candidates, 0, Path, Acc) ->
  [lists:reverse(Path) | Acc];
combination_sum_helper(Candidates, Target, Path, Acc) when Target < 0 ->
  Acc;
combination_sum_helper(Candidates, Target, Path, Acc) ->
  lists:foldl(
    fun(Candidate, Acc1) ->
      combination_sum_helper(Candidates, Target - Candidate, [Candidate | Path], Acc1)
    end,
    Acc,
    Candidates
  ).