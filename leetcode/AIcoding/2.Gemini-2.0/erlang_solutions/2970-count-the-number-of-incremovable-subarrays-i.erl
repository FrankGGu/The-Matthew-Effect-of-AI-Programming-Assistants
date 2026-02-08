-module(solution).
-export([count_subarrays/1]).

count_subarrays(Nums) ->
  N = length(Nums),
  count_valid_subarrays(Nums, N, 0).

count_valid_subarrays(_Nums, _N, Acc) ->
  count_valid_subarrays(_Nums, _N, Acc).

count_valid_subarrays(Nums, N, Acc) ->
  count_valid_subarrays(Nums, N, Acc, 0, 0).

count_valid_subarrays(Nums, N, Acc, Start, Count) ->
  if Start > N - 1 ->
    Acc + Count
  else
    count_valid_subarrays(Nums, N, Acc, Start, Count, 0, 0)
  end.

count_valid_subarrays(Nums, N, Acc, Start, Count, End, CurrentCount) ->
  if End > N ->
    Acc + Count + CurrentCount
  else
    NewCount = CurrentCount + (case is_incremovable(Nums, Start, End) of true -> 1; false -> 0 end),
    count_valid_subarrays(Nums, N, Acc, Start, Count, End + 1, NewCount)
  end.

is_incremovable(Nums, Start, End) ->
  N = length(Nums),
  Removed = lists:sublist(Nums, 1, Start) ++ lists:nthtail(End, Nums),
  is_strictly_increasing(Removed).

is_strictly_increasing([]) ->
  true;
is_strictly_increasing([_]) ->
  true;
is_strictly_increasing([H1, H2 | T]) ->
  if H1 < H2 then
    is_strictly_increasing([H2 | T])
  else
    false
  end.