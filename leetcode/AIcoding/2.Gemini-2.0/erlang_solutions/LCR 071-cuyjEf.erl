-module(solution).
-export([pickIndex/1]).

pickIndex(W) ->
  PrefixSum = lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], lists:reverse(W)),
  PrefixSumRev = lists:reverse(tl(PrefixSum)),
  RandomNum = random:uniform() * lists:last(PrefixSumRev),
  binary_search(PrefixSumRev, RandomNum, 0, length(PrefixSumRev) - 1).

binary_search(PrefixSum, Target, Low, High) ->
  if Low > High then
    Low
  else
    Mid = (Low + High) div 2,
    if lists:nth(Mid + 1, PrefixSum) < Target then
      binary_search(PrefixSum, Target, Mid + 1, High)
    else
      binary_search(PrefixSum, Target, Low, Mid - 1)
    end
  end.