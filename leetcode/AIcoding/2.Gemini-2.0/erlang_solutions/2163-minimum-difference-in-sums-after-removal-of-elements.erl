-module(minimum_difference).
-export([minimum_difference/1]).

minimum_difference(Nums) ->
  N = length(Nums),
  K = N div 3,
  {PrefixSums, SuffixSums} = calculate_sums(Nums, K),
  lists:foldl(
    fun(I, MinDiff) ->
      NewDiff = lists:nth(I, PrefixSums) - lists:nth(I, SuffixSums),
      min(MinDiff, NewDiff)
    end,
    infinity,
    lists:seq(K, 2 * K)
  ).

calculate_sums(Nums, K) ->
  Prefix = calculate_prefix_sums(Nums, K),
  Suffix = calculate_suffix_sums(Nums, K),
  {Prefix, Suffix}.

calculate_prefix_sums(Nums, K) ->
  N = length(Nums),
  PrefixNums = lists:sublist(Nums, 1, 2 * K),
  {_, PrefixSums} = lists:foldl(
    fun(Num, {Heap, Acc}) ->
      Heap2 = gb_sets:add(Num, Heap),
      if gb_sets:size(Heap2) > K then
        {NewHeap, Min} = gb_sets:take_smallest(Heap2),
        {NewHeap, [sum(NewHeap) || sum(NewHeap) <- [sum(Heap2) - Min | Acc]]}
      else
        {Heap2, [sum(Heap2) || sum(Heap2) <- [sum(Heap2) | Acc]]}
      end
    end,
    gb_sets:empty(),
    [],
    PrefixNums
  ),
  lists:reverse(PrefixSums).

calculate_suffix_sums(Nums, K) ->
  N = length(Nums),
  SuffixNums = lists:sublist(Nums, N - 2 * K + 1, 2 * K),
  {_, SuffixSums} = lists:foldl(
    fun(Num, {Heap, Acc}) ->
      Heap2 = gb_sets:add(Num, Heap),
      if gb_sets:size(Heap2) > K then
        {NewHeap, Max} = gb_sets:take_greatest(Heap2),
        {NewHeap, [sum(NewHeap) || sum(NewHeap) <- [sum(Heap2) - Max | Acc]]}
      else
        {Heap2, [sum(Heap2) || sum(Heap2) <- [sum(Heap2) | Acc]]}
      end
    end,
    gb_sets:empty(),
    [],
    lists:reverse(SuffixNums)
  ),
  lists:reverse(SuffixSums).

sum(Set) ->
  sum(gb_sets:to_list(Set)).

sum([]) ->
  0;
sum([H|T]) ->
  H + sum(T).