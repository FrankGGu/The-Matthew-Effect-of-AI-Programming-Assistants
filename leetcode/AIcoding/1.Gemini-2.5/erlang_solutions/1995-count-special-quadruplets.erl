-spec count_quadruplets(Nums :: [integer()]) -> integer().
count_quadruplets(Nums) ->
    Arr = array:from_list(Nums),
    Len = array:size(Arr),
    count_quadruplets_a(Arr, Len, 0, 0).

count_quadruplets_a(Arr, Len, A, Acc) ->
    if A >= Len - 3 ->
        Acc;
    true ->
        ValA = array:get(A, Arr),
        NewAcc = count_quadruplets_b(Arr, Len, ValA, A + 1, Acc),
        count_quadruplets_a(Arr, Len, A + 1, NewAcc)
    end.

count_quadruplets_b(Arr, Len, ValA, B, Acc) ->
    if B >= Len - 2 ->
        Acc;
    true ->
        ValB = array:get(B, Arr),
        NewAcc = count_quadruplets_c(Arr, Len, ValA, ValB, B + 1, Acc),
        count_quadruplets_b(Arr, Len, ValA, B + 1, NewAcc)
    end.

count_quadruplets_c(Arr, Len, ValA, ValB, C, Acc) ->
    if C >= Len - 1 ->
        Acc;
    true ->
        ValC = array:get(C, Arr),
        NewAcc = count_quadruplets_d(Arr, Len, ValA, ValB, ValC, C + 1, Acc),
        count_quadruplets_c(Arr, Len, ValA, ValB, C + 1, NewAcc)
    end.

count_quadruplets_d(Arr, Len, ValA, ValB, ValC, D, Acc) ->
    if D >= Len ->
        Acc;
    true ->
        ValD = array:get(D, Arr),
        CurrentAcc = if ValA + ValB + ValC == ValD ->
                           Acc + 1;
                       true ->
                           Acc
                       end,
        count_quadruplets_d(Arr, Len, ValA, ValB, ValC, D + 1, CurrentAcc)
    end.