-module(maximum_beauty).
-export([maximum_beauty/2]).

maximum_beauty(Nums, K) ->
  SortedNums = lists:sort(Nums),
  sliding_window(SortedNums, K, 0, 0).

sliding_window([], _, MaxBeauty, _) ->
  MaxBeauty;
sliding_window([H | T], K, MaxBeauty, Start) ->
  sliding_window(T, K, max(MaxBeauty, length(window(lists:sublist([H | T], Start), K))), Start + 1).

window(Nums, K) ->
  lists:filter(fun(X) -> X - lists:nth(1, Nums) <= 2 * K end, Nums).