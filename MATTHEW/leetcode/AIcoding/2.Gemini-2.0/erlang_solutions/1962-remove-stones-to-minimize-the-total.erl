-module(remove_stones).
-export([minStoneSum/2]).

minStoneSum(Piles, K) ->
  SortedPiles = lists:sort(fun(A, B) -> B - A end, Piles),
  minStoneSumHelper(SortedPiles, K, 0).

minStoneSumHelper([], _, Sum) ->
  Sum;
minStoneSumHelper(Piles, 0, Sum) ->
  lists:sum(Piles);
minStoneSumHelper([Pile | Rest], K, Sum) ->
  HalvedPile = Pile div 2,
  NewPiles = lists:merge(fun(A, B) -> B >= A end, [HalvedPile], Rest),
  minStoneSumHelper(NewPiles, K - 1, Sum).