-module(mice_and_cheese).
-export([max_mice]).

max_mice(reward1, reward2, k) ->
  N = length(reward1),
  Diffs = lists:zipwith(fun(R1, R2) -> R1 - R2 end, reward1, reward2),
  SortedDiffs = lists:keysort(1, lists:zip(Diffs, lists:seq(1, N))),
  {Sum1, Sum2} = lists:foldl(fun({Diff, Index}, {Acc1, Acc2}) ->
                                if Index =< k then
                                  {Acc1 + lists:nth(Index, reward1), Acc2}
                                else
                                  {Acc1, Acc2 + lists:nth(Index, reward2)}
                                end
                              end, {0, 0}, SortedDiffs),
  Sum1 + Sum2.