-module(kth_smallest_trimmed_number).
-export([kth_smallest_trimmed_number/2]).

kth_smallest_trimmed_number(Nums, Queries) ->
  lists:map(fun(Query) -> kth_smallest(Nums, Query) end, Queries).

kth_smallest(Nums, [K, Trim]) ->
  Len = length(hd(Nums)),
  Trimmed_Nums = lists:map(fun(Num) -> trim(Num, Len - Trim) end, Nums),
  Indexed_Nums = lists:zip(Trimmed_Nums, lists:seq(1, length(Nums))),
  Sorted_Nums = lists:keysort(1, Indexed_Nums),
  {_, Index} = lists:nth(K, Sorted_Nums),
  Index - 1.

trim(Num, Start) ->
  list_to_binary(lists:sublist(binary_to_list(list_to_binary(Num)), Start + 1)).