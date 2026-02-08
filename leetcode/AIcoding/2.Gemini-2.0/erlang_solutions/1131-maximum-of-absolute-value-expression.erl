-module(maximum_absolute_value_expression).
-export([max_abs_val_expr/2]).

max_abs_val_expr(Arr1, Arr2) ->
  N = length(Arr1),
  A = lists:zip(Arr1, Arr2),
  max_abs_val_expr_helper(A, N, -1000000000, -1000000000, -1000000000, -1000000000,
                        1000000000, 1000000000, 1000000000, 1000000000, 0).

max_abs_val_expr_helper([], _N, Max1, Max2, Max3, Max4, Min1, Min2, Min3, Min4, MaxRes) ->
  MaxRes1 = Max1 - Min1,
  MaxRes2 = Max2 - Min2,
  MaxRes3 = Max3 - Min3,
  MaxRes4 = Max4 - Min4,
  lists:max([MaxRes, MaxRes1, MaxRes2, MaxRes3, MaxRes4]);

max_abs_val_expr_helper([{X, Y} | Rest], N, Max1, Max2, Max3, Max4, Min1, Min2, Min3, Min4, MaxRes) ->
  I = N - length(Rest),
  Val1 = X + Y + I,
  Val2 = X - Y + I,
  Val3 = X + Y - I,
  Val4 = X - Y - I,
  NewMax1 = max(Max1, Val1),
  NewMax2 = max(Max2, Val2),
  NewMax3 = max(Max3, Val3),
  NewMax4 = max(Max4, Val4),
  NewMin1 = min(Min1, Val1),
  NewMin2 = min(Min2, Val2),
  NewMin3 = min(Min3, Val3),
  NewMin4 = min(Min4, Val4),
  max_abs_val_expr_helper(Rest, N, NewMax1, NewMax2, NewMax3, NewMax4, NewMin1, NewMin2, NewMin3, NewMin4, MaxRes).