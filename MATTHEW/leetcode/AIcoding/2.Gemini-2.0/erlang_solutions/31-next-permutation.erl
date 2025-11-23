-module(next_permutation).
-export([next_permutation/1]).

next_permutation(Nums) ->
  Len = length(Nums),
  next_permutation_helper(Nums, Len).

next_permutation_helper(Nums, Len) ->
  I = find_first_decreasing(Nums, Len),
  case I of
    -1 ->
      lists:reverse(Nums);
    _ ->
      J = find_first_greater(Nums, I, Len),
      {NewNums1, _} = lists:split(I, Nums),
      {_, NewNums2} = lists:split(J - I, lists:nthtail(I, Nums)),
      {NewNums3, _} = lists:split(Len - J - 1, lists:nthtail(J + 1, Nums)),
      NewNums = NewNums1 ++ [lists:nth(J - I, lists:nthtail(I, Nums))] ++ NewNums3 ++ [lists:nth(0, lists:nthtail(I, Nums))] ++ lists:reverse(NewNums2),
      NewNums
  end.

find_first_decreasing(Nums, Len) ->
  find_first_decreasing_helper(Nums, Len - 2, Len).

find_first_decreasing_helper(Nums, I, Len) ->
  if
    I < 0 ->
      -1;
    true ->
      if
        lists:nth(I, Nums) < lists:nth(I + 1, Nums) ->
          I;
        true ->
          find_first_decreasing_helper(Nums, I - 1, Len)
      end
  end.

find_first_greater(Nums, I, Len) ->
  find_first_greater_helper(Nums, I, Len - 1, Len).

find_first_greater_helper(Nums, I, J, Len) ->
  if
    lists:nth(J, Nums) > lists:nth(I, Nums) ->
      J;
    true ->
      find_first_greater_helper(Nums, I, J - 1, Len)
  end.