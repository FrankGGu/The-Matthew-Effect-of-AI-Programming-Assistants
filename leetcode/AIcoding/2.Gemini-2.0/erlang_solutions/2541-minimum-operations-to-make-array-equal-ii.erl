-module(minimum_operations_to_make_array_equal_ii).
-export([minOperations/3]).

minOperations(Nums1, Nums2, K) ->
  min_operations(Nums1, Nums2, K, 0, 0).

min_operations([], [], _, Pos, Neg) ->
  if Pos == Neg then
    Pos
  else
    -1
  end;
min_operations([H1|T1], [H2|T2], K, Pos, Neg) ->
  Diff = H1 - H2,
  if Diff == 0 then
    min_operations(T1, T2, K, Pos, Neg)
  else
    if K == 0 then
      -1
    else
      if Diff rem K == 0 then
        if Diff > 0 then
          min_operations(T1, T2, K, Pos + (Diff div K), Neg)
        else
          min_operations(T1, T2, K, Pos, Neg + (abs(Diff) div K))
        end
      else
        -1
      end
    end
  end.