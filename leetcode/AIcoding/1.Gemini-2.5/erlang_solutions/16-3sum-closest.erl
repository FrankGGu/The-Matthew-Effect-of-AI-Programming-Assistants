-module(solution).
-export([three_sum_closest/2]).

three_sum_closest(Nums, Target) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),

    TupleNums = list_to_tuple(SortedNums),

    InitialClosestSum = element(1, TupleNums) + element(2, TupleNums) + element(3, TupleNums),

    loop_i(0, Len, Target, TupleNums, InitialClosestSum).

loop_i(I, Len, Target, TupleNums, ClosestSum) when I < Len - 2 ->
    NumI = element(I + 1, TupleNums),

    Left = I + 1,
    Right = Len - 1,

    ResultFromTwoPointers = loop_two_pointers(Left, Right, NumI, Target, TupleNums, ClosestSum),

    if ResultFromTwoPointers == Target ->
        Target;
    true ->
        loop_i(I + 1, Len, Target, TupleNums, ResultFromTwoPointers)
    end;
loop_i(_I, _Len, _Target, _TupleNums, ClosestSum) ->
    ClosestSum.

loop_two_pointers(Left, Right, NumI, Target, TupleNums, CurrentClosestSum) when Left < Right ->
    NumL = element(Left + 1, TupleNums),
    NumR = element(Right + 1, TupleNums),

    CurrentSum = NumI + NumL + NumR,

    if CurrentSum == Target ->
        Target;
    true ->
        NewClosestSum = 
            case abs(CurrentSum - Target) < abs(CurrentClosestSum - Target) of
                true -> CurrentSum;
                false -> CurrentClosestSum
            end,

        if CurrentSum < Target ->
            loop_two_pointers(Left + 1, Right, NumI, Target, TupleNums, NewClosestSum);
        true -> 
            loop_two_pointers(Left, Right - 1, NumI, Target, TupleNums, NewClosestSum)
        end
    end;
loop_two_pointers(_Left, _Right, _NumI, _Target, _TupleNums, CurrentClosestSum) ->
    CurrentClosestSum.