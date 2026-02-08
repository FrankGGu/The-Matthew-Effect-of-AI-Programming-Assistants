-module(solution).
-export([threeSum/1]).

threeSum(Nums) ->
    SortedNums = lists:sort(Nums),
    Arr = array:from_list(SortedNums),
    Len = array:size(Arr),
    threeSum_array_loop(Arr, Len, 0, []).

threeSum_array_loop(Arr, Len, I, Acc) ->
    if I >= Len - 2 -> lists:reverse(Acc);
       true ->
            A = array:get(I, Arr),
            if I > 0 andalso A == array:get(I - 1, Arr) ->
                threeSum_array_loop(Arr, Len, I + 1, Acc);
            true ->
                Target = -A,
                Left = I + 1,
                Right = Len - 1,
                NewAcc = two_sum_array_pointers(Arr, A, Target, Left, Right, Acc),
                threeSum_array_loop(Arr, Len, I + 1, NewAcc)
            end
    end.

two_sum_array_pointers(Arr, A, Target, Left, Right, Acc) ->
    if Left >= Right -> Acc;
       true ->
            B = array:get(Left, Arr),
            C = array:get(Right, Arr),
            Sum = B + C,
            if Sum == Target ->
                Triplet = [A, B, C],
                NewLeft = Left + 1,
                NewRight = Right - 1,
                NewLeft2 = skip_duplicates_array_left(Arr, NewLeft, Right, B),
                NewRight2 = skip_duplicates_array_right(Arr, Left, NewRight, C),
                two_sum_array_pointers(Arr, A, Target, NewLeft2, NewRight2, [Triplet | Acc]);
            Sum < Target ->
                NewLeft = Left + 1,
                two_sum_array_pointers(Arr, A, Target, NewLeft, Right, Acc);
            Sum > Target ->
                NewRight = Right - 1,
                two_sum_array_pointers(Arr, A, Target, Left, NewRight, Acc)
            end
    end.

skip_duplicates_array_left(Arr, Left, Right, Val) ->
    if Left < Right andalso array:get(Left, Arr) == Val ->
        skip_duplicates_array_left(Arr, Left + 1, Right, Val);
    true -> Left
    end.

skip_duplicates_array_right(Arr, Left, Right, Val) ->
    if Right > Left andalso array:get(Right, Arr) == Val ->
        skip_duplicates_array_right(Arr, Left, Right - 1, Val);
    true -> Right
    end.