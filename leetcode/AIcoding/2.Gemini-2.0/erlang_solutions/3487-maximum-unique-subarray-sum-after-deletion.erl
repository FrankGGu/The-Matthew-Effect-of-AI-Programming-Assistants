-module(maximum_unique_subarray).
-export([maximum_unique_subarray/1]).

maximum_unique_subarray(Nums) ->
  maximum_unique_subarray(Nums, 0, 0, sets:new(), 0).

maximum_unique_subarray([], _, _, _, Max) ->
  Max;
maximum_unique_subarray(Nums, Left, Right, Seen, CurrentSum) ->
  case Nums of
    [] -> CurrentSum;
    [Num | Rest] ->
      case sets:is_element(Num, Seen) of
        true ->
          {LeftNew, CurrentSumNew, SeenNew} =
            remove_left(lists:sublist(Nums, Left+1), sets:new(), Left, lists:nth(Left+1, Nums), Seen, CurrentSum);
          maximum_unique_subarray(Nums, LeftNew, Right + 1, sets:add_element(Num, SeenNew), CurrentSumNew + Num) of
            Max1 ->
              maximum(Max1, maximum_unique_subarray(Rest, 0, 0, sets:new(), 0))
          end;
        false ->
          Max1 = maximum_unique_subarray(Rest, Left, Right + 1, sets:add_element(Num, Seen), CurrentSum + Num),
          maximum(CurrentSum + Num, Max1)
      end
  end.

remove_left([], Seen, Left, _, Seen, CurrentSum) ->
  {Left+1, CurrentSum, Seen};

remove_left(Nums, Seen, Left, Target, OldSeen, CurrentSum) ->
  case Nums of
    [] -> {Left+1, CurrentSum, OldSeen};
    [Num | Rest] ->
      case sets:is_element(Target, OldSeen) of
        true ->
          {Left+1, CurrentSum - Target, sets:del_element(Target, OldSeen)};
        false ->
          {Left+1, CurrentSum, OldSeen}
      end
  end.

maximum(A, B) ->
  if A > B -> A;
     true -> B
  end.