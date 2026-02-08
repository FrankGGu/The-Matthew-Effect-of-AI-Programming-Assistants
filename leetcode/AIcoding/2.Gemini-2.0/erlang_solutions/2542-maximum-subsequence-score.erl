-module(maximum_subsequence_score).
-export([maximum_score/2]).

maximum_score(Nums1, Nums2, K) ->
  N = length(Nums1),
  Indices = lists:seq(1, N),
  Pairs = lists:zip(Nums2, Nums1, Indices),
  SortedPairs = lists:sort(fun({A, _, _}, {B, _, _}) -> A >= B end, Pairs),
  {Score, _} = solve(SortedPairs, K, 0, 0, gb_sets:empty()),
  Score.

solve([], K, CurrentScore, CurrentSum, Selected) ->
  case gb_sets:size(Selected) =:= K of
    true -> {CurrentScore, Selected};
    false -> {0, gb_sets:empty()}
  end;
solve([{MinNum, Num, Index} | Rest], K, CurrentScore, CurrentSum, Selected) ->
  case gb_sets:size(Selected) =:= K of
    true ->
      {MinHeap, Total} = create_min_heap_and_total(Selected, Nums1, Nums2),
      {NewMinHeap, MinValue} = heap:delete_min(MinHeap),
      NewTotal = Total - MinValue,
      NewScore = (NewTotal + Num) * MinNum,
      NewSelected = gb_sets:add(Index, Selected),
      {NewHeap, _} = heap:insert(MinValue, MinValue, NewMinHeap),
      {max(CurrentScore, NewScore), NewSelected};
    false ->
      NewSelected = gb_sets:add(Index, Selected),
      NewSum = CurrentSum + Num,
      case gb_sets:size(NewSelected) =:= K of
        true ->
          NewScore = NewSum * MinNum,
          {max(CurrentScore, NewScore), NewSelected};
        false ->
          solve(Rest, K, CurrentScore, NewSum, NewSelected)
      end
  end.

create_min_heap_and_total(Set, Nums1, Nums2) ->
  create_min_heap_and_total_helper(gb_sets:to_list(Set), Nums1, Nums2, heap:new(), 0).

create_min_heap_and_total_helper([], _, _, Heap, Total) ->
  {Heap, Total};
create_min_heap_and_total_helper([Index | Rest], Nums1, Nums2, Heap, Total) ->
  Num = lists:nth(Index, Nums1),
  create_min_heap_and_total_helper(Rest, Nums1, Nums2, heap:insert(Num, Num, Heap), Total + Num).