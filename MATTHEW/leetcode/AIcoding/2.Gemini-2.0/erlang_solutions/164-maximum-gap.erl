-module(maximum_gap).
-export([maximum_gap/1]).

maximum_gap(Nums) ->
  maximum_gap(Nums, length(Nums)).

maximum_gap([], _) ->
  0;
maximum_gap([_], _) ->
  0;
maximum_gap(Nums, N) ->
  MinMax = lists:foldl(
    fun(X, {Min, Max}) ->
      {min(Min, X), max(Max, X)}
    end,
    {hd(Nums), hd(Nums)},
    tl(Nums)
  ),
  {MinVal, MaxVal} = MinMax,

  if MinVal == MaxVal ->
    0
  else
    BucketSize = max(1, floor((MaxVal - MinVal) / (N - 1))),
    BucketCount = floor((MaxVal - MinVal) / BucketSize) + 1,

    Buckets = lists:foldl(
      fun(Num, Acc) ->
        Index = floor((Num - MinVal) / BucketSize),
        case lists:keyfind(Index, 1, Acc) of
          false ->
            [{Index, {Num, Num}} | Acc];
          {Index, {Min, Max}} ->
            lists:keyreplace(Index, 1, Acc, {Index, {min(Min, Num), max(Max, Num)}})
        end
      end,
      [],
      Nums
    ),

    SortedBuckets = lists:sort(fun({A, _}, {B, _}) -> A < B end, Buckets),

    lists:foldl(
      fun({_, {_, Max}}, {PrevMax, MaxGap}) ->
        case PrevMax of
          none ->
            {Max, MaxGap};
          _ ->
            NewMaxGap = max(MaxGap, Max - PrevMax),
            {Max, NewMaxGap}
        end
      end,
      {none, 0},
      lists:zip(tl(SortedBuckets), SortedBuckets)
    )
    ||
    SortedBuckets =/= [],
    lists:last(SortedBuckets) =/= hd(SortedBuckets),
    lists:nth(1, lists:foldl(
      fun({_, {Min, _}}, {PrevMax, MaxGap}) ->
        case PrevMax of
          none ->
            {Min, MaxGap};
          _ ->
            NewMaxGap = max(MaxGap, Min - PrevMax),
            {Min, NewMaxGap}
        end
      end,
      {none, 0},
      SortedBuckets))
  end.