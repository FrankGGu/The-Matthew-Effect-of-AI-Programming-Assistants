-module(ways_to_split).
-export([number_of_ways/1]).

number_of_ways(Nums) ->
  length(Nums) < 3 andalso 0 || solve(Nums).

solve(Nums) ->
  N = length(Nums),
  PrefixSums = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Nums)),
  PrefixSumsRev = lists:reverse(PrefixSums),
  solve_helper(PrefixSumsRev, 1, 0).

solve_helper(PrefixSums, I, Count) when I >= length(PrefixSums) - 1 ->
  Count;
solve_helper(PrefixSums, I, Count) ->
  N = length(PrefixSums),
  First = lists:nth(I, PrefixSums) - lists:nth(1, PrefixSums),

  {Left, Right} = find_range(PrefixSums, I, N - 1, First),

  NewCount = Count + max(0, Right - Left + 1),
  solve_helper(PrefixSums, I + 1, NewCount).

find_range(PrefixSums, I, J, First) ->
  {find_left(PrefixSums, I, J, First), find_right(PrefixSums, I, J, First)}.

find_left(PrefixSums, I, J, First) ->
  find_left_helper(PrefixSums, I, J, First, I - 1).

find_left_helper(PrefixSums, I, J, First, Acc) when I > J ->
  Acc;
find_left_helper(PrefixSums, I, J, First, Acc) ->
  Mid = (I + J) div 2,
  Second = lists:nth(Mid + 1, PrefixSums) - lists:nth(I, PrefixSums),
  Third = lists:nth(length(PrefixSums), PrefixSums) - lists:nth(Mid + 1, PrefixSums);
  if
    First > Second ->
      find_left_helper(PrefixSums, Mid + 1, J, First, Acc);
    Second > Third ->
      find_left_helper(PrefixSums, I, Mid - 1, First, Acc);
    true ->
      find_left_helper(PrefixSums, I, Mid - 1, First, Mid - 1)
  end.

find_right(PrefixSums, I, J, First) ->
  find_right_helper(PrefixSums, I, J, First, I - 1).

find_right_helper(PrefixSums, I, J, First, Acc) when I > J ->
  Acc;
find_right_helper(PrefixSums, I, J, First, Acc) ->
  Mid = (I + J) div 2,
  Second = lists:nth(Mid + 1, PrefixSums) - lists:nth(I, PrefixSums),
  Third = lists:nth(length(PrefixSums), PrefixSums) - lists:nth(Mid + 1, PrefixSums);
  if
    First > Second ->
      find_right_helper(PrefixSums, Mid + 1, J, First, Acc);
    Second > Third ->
      find_right_helper(PrefixSums, I, Mid - 1, First, Acc);
    true ->
      find_right_helper(PrefixSums, Mid + 1, J, First, Mid)
  end.