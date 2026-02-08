-module(pancake_sort).
-export([pancakeSort/1]).

pancakeSort(Arr) ->
  N = length(Arr),
  pancakeSortHelper(Arr, N, []).

pancakeSortHelper(Arr, 1, Acc) ->
  lists:reverse(Acc);
pancakeSortHelper(Arr, N, Acc) ->
  {MaxVal, MaxIndex} = findMax(Arr, N),
  case MaxIndex of
    N ->
      pancakeSortHelper(lists:sublist(Arr, 1, N - 1), N - 1, Acc);
    _ ->
      Flipped1 = flip(Arr, MaxIndex),
      Flipped2 = flip(Flipped1, N),
      pancakeSortHelper(lists:sublist(Flipped2, 1, N - 1), N - 1, [MaxIndex | [N | Acc]])
  end.

findMax(Arr, N) ->
  findMaxHelper(Arr, 1, N, lists:nth(1, Arr), 1).

findMaxHelper(Arr, I, N, MaxVal, MaxIndex) when I > N ->
  {MaxVal, MaxIndex};
findMaxHelper(Arr, I, N, MaxVal, MaxIndex) ->
  Val = lists:nth(I, Arr),
  if
    Val > MaxVal ->
      findMaxHelper(Arr, I + 1, N, Val, I);
    true ->
      findMaxHelper(Arr, I + 1, N, MaxVal, MaxIndex)
  end.

flip(Arr, K) ->
  flipHelper(Arr, 1, K, []).

flipHelper(Arr, I, K, Acc) when I > K ->
  lists:append(lists:reverse(Acc), lists:sublist(Arr, K + 1, length(Arr) - K));
flipHelper(Arr, I, K, Acc) ->
  flipHelper(Arr, I + 1, K, [lists:nth(I, Arr) | Acc]).