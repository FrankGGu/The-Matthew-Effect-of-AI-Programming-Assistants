-module(maximum_strength_k_disjoint_subarrays).
-export([max_strength/2]).

max_strength(Nums, K) ->
  length(Nums) < K * 2 orelse K < 1  orelse K > length(Nums) div 2  -> 0;
  max_strength(Nums, K, 0, length(Nums) - 1, []).

max_strength(Nums, K, Start, End, Acc) when K == 0 ->
  lists:sum(Acc);
max_strength(Nums, K, Start, End, Acc) when Start > End ->
  lists:sum(Acc);
max_strength(Nums, K, Start, End, Acc) ->
  Include_First = max_subarray(Nums, Start, End),
  case Include_First of
      0 ->
          Exclude_First = max_strength(Nums, K, Start + 1, End, Acc),
          Exclude_First;
      _ ->
          Exclude_First = max_strength(Nums, K, Start + 1, End, Acc),
          Include_First_Val = max_strength(Nums, K - 1, Start + find_length(Nums, Start, End), End, [Include_First | Acc]),
          max(Include_First_Val, Exclude_First)
  end.

find_length(Nums, Start, End) ->
    find_length(Nums, Start, End, 1, 0, 0).

find_length(Nums, Start, End, Len, Current, Max) ->
    if Start + Len - 1 > End then
        1;
    else
        NewCurrent = Current + Nums[Start + Len - 1],
        if NewCurrent > Max then
            find_length(Nums, Start, End, Len+1, NewCurrent, NewCurrent);
        else
            find_length(Nums, Start, End, Len+1, NewCurrent, Max)
        end
    end.

max_subarray(Nums, Start, End) ->
  max_subarray(Nums, Start, End, 0, 0).

max_subarray(Nums, Start, End, Current, Max) when Start > End ->
  Max;
max_subarray(Nums, Start, End, Current, Max) ->
  NewCurrent = Current + Nums[Start],
  NewMax = max(NewCurrent, Max),
  if NewCurrent < 0 then
      max_subarray(Nums, Start + 1, End, 0, NewMax);
  else
      max_subarray(Nums, Start + 1, End, NewCurrent, NewMax)
  end.

max(A, B) ->
  if A > B then
    A
  else
    B
  end.