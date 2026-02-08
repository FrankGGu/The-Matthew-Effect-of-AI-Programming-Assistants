-module(three_sum).
-export([three_sum/1]).

three_sum(Nums) ->
  Len = length(Nums),
  case Len < 3 of
    true -> [];
    false ->
      SortedNums = lists:sort(Nums),
      three_sum_helper(SortedNums, Len, 0, [])
  end.

three_sum_helper(Nums, Len, I, Acc) ->
  case I >= Len - 2 of
    true -> lists:reverse(Acc);
    false ->
      case I > 0 andalso lists:nth(I, Nums) == lists:nth(I - 1, Nums) of
        true -> three_sum_helper(Nums, Len, I + 1, Acc);
        false ->
          L = I + 1,
          R = Len - 1,
          Target = -lists:nth(I + 1, Nums),
          three_sum_two_pointers(Nums, Target, L, R, lists:nth(I + 1, Nums), Acc, Len, I)
      end
  end.

three_sum_two_pointers(Nums, Target, L, R, FirstNum, Acc, Len, I) ->
  case L >= R of
    true -> three_sum_helper(Nums, Len, I + 1, Acc);
    false ->
      Sum = lists:nth(L + 1, Nums) + lists:nth(R + 1, Nums),
      case Sum of
        Target when Target < Target ->
          three_sum_two_pointers(Nums, Target, L + 1, R, FirstNum, Acc, Len, I);
        Target when Target > Target ->
          three_sum_two_pointers(Nums, Target, L, R - 1, FirstNum, Acc, Len, I);
        _ ->
          NewAcc = [[FirstNum, lists:nth(L + 1, Nums), lists:nth(R + 1, Nums)] | Acc],
          NewL = skip_duplicates_left(Nums, L, R),
          NewR = skip_duplicates_right(Nums, L, R),
          three_sum_two_pointers(Nums, Target, NewL, NewR, FirstNum, NewAcc, Len, I)
      end
  end.

skip_duplicates_left(Nums, L, R) ->
  Value = lists:nth(L + 1, Nums),
  skip_duplicates_left_helper(Nums, L + 1, R, Value).

skip_duplicates_left_helper(Nums, L, R, Value) ->
  case L >= R orelse lists:nth(L + 1, Nums) /= Value of
    true -> L;
    false -> skip_duplicates_left_helper(Nums, L + 1, R, Value)
  end.

skip_duplicates_right(Nums, L, R) ->
  Value = lists:nth(R + 1, Nums),
  skip_duplicates_right_helper(Nums, L, R - 1, Value).

skip_duplicates_right_helper(Nums, L, R, Value) ->
  case L >= R orelse lists:nth(R + 1, Nums) /= Value of
    true -> R;
    false -> skip_duplicates_right_helper(Nums, L, R - 1, Value)
  end.