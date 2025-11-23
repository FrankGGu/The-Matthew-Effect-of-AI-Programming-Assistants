-module(combination_sum_ii).
-export([combinationSum2/2]).

combinationSum2(Candidates, Target) ->
  UniqueCandidates = lists:usort(Candidates),
  findCombinations(UniqueCandidates, Target, [], []).

findCombinations([], 0, Acc, Result) ->
  [lists:reverse(Acc) | Result];
findCombinations([], Target, _, Result) when Target < 0 ->
  Result;
findCombinations([], _, _, Result) ->
  Result;
findCombinations([H | T], Target, Acc, Result) when Target < 0 ->
  Result;
findCombinations([H | T], Target, Acc, Result) ->
  Result1 = findCombinations(T, Target - H, [H | Acc], Result),
  Skip = skipDuplicates(T, H),
  findCombinations(Skip, Target, Acc, Result1).

skipDuplicates([H | T], H) ->
  skipDuplicates(T, H);
skipDuplicates(L, _) ->
  L.