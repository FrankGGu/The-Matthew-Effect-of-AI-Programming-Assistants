-module(max_distinct_elements).
-export([find_max_distinct_elements/2]).

find_max_distinct_elements(Nums, K) ->
  Counts = lists:foldl(fun(Num, Acc) ->
    case maps:is_key(Num, Acc) of
      true -> maps:update(Num, maps:get(Num, Acc) + 1, Acc);
      false -> maps:put(Num, 1, Acc)
    end
  end, #{}, Nums),
  CountList = maps:values(Counts),
  SortedCounts = lists:sort(CountList),
  {Distinct, RemainingK} = lists:foldl(fun(Count, {DistinctAcc, KAcc}) ->
    case Count - 1 =< KAcc of
      true -> {DistinctAcc, KAcc - (Count - 1)};
      false -> {DistinctAcc + 1, KAcc}
    end
  end, {0, K}, SortedCounts),

  TotalDistinct = maps:size(Counts) - Distinct,

  min(TotalDistinct + min(RemainingK, Distinct), length(Nums)).