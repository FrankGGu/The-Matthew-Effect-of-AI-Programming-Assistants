-module(partition_array).
-export([minimum_difference/1]).

minimum_difference(Nums) ->
  N = length(Nums),
  Sum = lists:sum(Nums),
  Half = N div 2,
  LeftSums = get_sums(lists:sublist(Nums, 1, Half)),
  RightSums = get_sums(lists:sublist(Nums, Half + 1, N - Half)),
  SortedRightSums = lists:sort(RightSums),
  minimum_difference_helper(LeftSums, SortedRightSums, Sum).

get_sums(Nums) ->
  N = length(Nums),
  get_sums_helper(Nums, N).

get_sums_helper(_Nums, 0) ->
  [0];
get_sums_helper(Nums, K) ->
  get_sums_helper2(Nums, K, []).

get_sums_helper2([], _K, Acc) ->
  Acc;
get_sums_helper2(Nums, K, Acc) ->
  NewAcc = lists:foldl(fun(X, Acc2) -> [X | Acc2] end, [], combinations(Nums, K)),
  get_sums_helper2(Nums, K - 1, lists:append(Acc, NewAcc)).

combinations(List, 0) -> [[]];
combinations([], _) -> [];
combinations([H|T], K) when K > 0 ->
  [[H|C] || C <- combinations(T, K-1)] ++ combinations(T, K).

minimum_difference_helper(LeftSums, RightSums, Sum) ->
  lists:foldl(fun(LeftSum, MinDiff) ->
                  RightSum = find_closest(RightSums, (Sum div 2) - LeftSum),
                  Diff = abs(Sum - 2 * (LeftSum + RightSum)),
                  min(MinDiff, Diff)
              end, 1000000000, LeftSums).

find_closest(List, Target) ->
  find_closest_helper(List, Target, hd(List)).

find_closest_helper([H|T], Target, Closest) ->
  DiffH = abs(H - Target),
  DiffClosest = abs(Closest - Target),
  NewClosest = case DiffH < DiffClosest of
                 true -> H;
                 false -> Closest
               end,
  case T of
    [] -> NewClosest;
    _ -> find_closest_helper(T, Target, NewClosest)
  end.