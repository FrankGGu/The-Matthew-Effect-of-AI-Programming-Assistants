-module(valid_partition).
-export([valid_partition/1]).

valid_partition(Nums) ->
  N = length(Nums),
  DP = array:new(N + 1, {fixed, false}),
  array:set(N, true, DP),
  valid_partition_helper(Nums, N - 1, DP).

valid_partition_helper(Nums, Index, DP) when Index < 0 ->
  array:get(0, DP);
valid_partition_helper(Nums, Index, DP) ->
  N = length(Nums),
  case check_partitions(Nums, Index) of
    {true, 2} ->
      NewDP = array:set(Index, array:get(Index + 2, DP), DP),
      valid_partition_helper(Nums, Index - 1, NewDP);
    {true, 3} ->
      NewDP1 = array:set(Index, array:get(Index + 3, DP), DP),
      case check_partitions(Nums, Index, 2) of
        {true, 2} ->
          NewDP2 = array:set(Index, array:get(Index + 2, DP), DP),
          NewDP = array:set(Index, array:get(Index, DP) or array:get(Index, NewDP2), NewDP1),
          valid_partition_helper(Nums, Index - 1, NewDP);
        _ ->
          valid_partition_helper(Nums, Index - 1, NewDP1)
      end;
    _ ->
      NewDP1 = array:set(Index, false, DP),
      case check_partitions(Nums, Index, 2) of
        {true, 2} ->
          NewDP2 = array:set(Index, array:get(Index + 2, DP), DP),
          NewDP = array:set(Index, array:get(Index, DP) or array:get(Index, NewDP2), NewDP1),
          valid_partition_helper(Nums, Index - 1, NewDP);
        _ ->
          valid_partition_helper(Nums, Index - 1, NewDP1)
      end
  end.

check_partitions(Nums, Index) ->
  N = length(Nums),
  if Index + 1 >= N then
    {false, 0}
  else if Nums == [] then
      {false, 0}
  else if Nums[Index + 1] =:= Nums[Index + 2] then
    {true, 2}
  else
    {false, 0}
  end.

check_partitions(Nums, Index, 2) ->
  N = length(Nums),
  if Index + 2 >= N then
    {false, 0}
  else if Nums[Index + 1] =:= Nums[Index + 2] andalso Nums[Index + 2] =:= Nums[Index + 3] then
    {true, 3}
  else if Nums[Index + 1] + 1 =:= Nums[Index + 2] andalso Nums[Index + 2] + 1 =:= Nums[Index + 3] then
    {true, 3}
  else
    {false, 0}
  end.