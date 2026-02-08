-module(divide_array).
-export([divide_array/1]).

divide_array(Nums) ->
  divide_array(Nums, 3).

divide_array(Nums, K) ->
  SortedNums = lists:sort(Nums),
  Len = length(SortedNums),
  if Len rem K /= 0 ->
    []
  else
    divide_array_helper(SortedNums, K, [])
  end.

divide_array_helper([], _K, Acc) ->
  lists:reverse(Acc);
divide_array_helper(Nums, K, Acc) ->
  [First, Second, Third | Rest] = Nums,
  if (Second - First) > (Nums -- [Third]) || (Third - First) > 200 || (Third - First) > 0 ->
    []
  else
    if (Second - First) > 0, (Third - First) > 0 ->
        divide_array_helper(Rest, K, [[First, Second, Third] | Acc])

    else
        []
    end
  end.