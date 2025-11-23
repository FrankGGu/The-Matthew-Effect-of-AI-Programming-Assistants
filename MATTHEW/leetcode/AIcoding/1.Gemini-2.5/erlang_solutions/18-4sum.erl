-module(solution).
-export([four_sum/2]).

four_sum(Nums, Target) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),

    if Len < 4 ->
        [];
    true ->
        Arr = array:from_list(SortedNums),
        Result = four_sum_loop_i(Arr, Len, Target, 0, []),
        lists:reverse(Result)
    end.

four_sum_loop_i(Arr, Len, Target, I, Acc) when I < Len - 3 ->
    case I > 0 andalso array:get(I, Arr) == array:get(I - 1, Arr) of
        true ->
            four_sum_loop_i(Arr, Len, Target, I + 1, Acc);
        false ->
            NumI = array:get(I, Arr),
            NewAcc = four_sum_loop_j(Arr, Len, Target, I, NumI, I + 1, Acc),
            four_sum_loop_i(Arr, Len, Target, I + 1, NewAcc)
    end;
four_sum_loop_i(_Arr, _Len, _Target, _I, Acc) ->
    Acc.

four_sum_loop_j(Arr, Len, Target, I, NumI, J, Acc) when J < Len - 2 ->
    case J > I + 1 andalso array:get(J, Arr) == array:get(J - 1, Arr) of
        true ->
            four_sum_loop_j(Arr, Len, Target, I, NumI, J + 1, Acc);
        false ->
            NumJ = array:get(J, Arr),
            Left = J + 1,
            Right = Len - 1,
            NewAcc = two_sum_pointers(Arr, Target - NumI - NumJ, NumI, NumJ, Left, Right, Acc),
            four_sum_loop_j(Arr, Len, Target, I, NumI, J + 1, NewAcc)
    end;
four_sum_loop_j(_Arr, _Len, _Target, _I, _NumI, _J, Acc) ->
    Acc.

two_sum_pointers(Arr, SubTarget, NumI, NumJ, Left, Right, Acc) when Left < Right ->
    NumLeft = array:get(Left, Arr),
    NumRight = array:get(Right, Arr),
    CurrentSum = NumLeft + NumRight,

    case CurrentSum of
        SubTarget ->
            Quad = [NumI, NumJ, NumLeft, NumRight],
            NewAcc = [Quad | Acc],

            NextLeft = Left + 1,
            NewLeft = skip_duplicates_left(Arr, NextLeft, Right, NumLeft),

            NextRight = Right - 1,
            NewRight = skip_duplicates_right(Arr, NewLeft, NextRight, NumRight),

            two_sum_pointers(Arr, SubTarget, NumI, NumJ, NewLeft, NewRight, NewAcc);
        _ when CurrentSum < SubTarget ->
            NextLeft = Left + 1,
            two_sum_pointers(Arr, SubTarget, NumI, NumJ, NextLeft, Right, Acc);
        _ when CurrentSum > SubTarget ->
            NextRight = Right - 1,
            two_sum_pointers(Arr, SubTarget, NumI, NumJ, Left, NextRight, Acc)
    end;
two_sum_pointers(_Arr, _SubTarget, _NumI, _NumJ, _Left, _Right, Acc) ->
    Acc.

skip_duplicates_left(Arr, Left, Right, Val) when Left < Right andalso array:get(Left, Arr) == Val ->
    skip_duplicates_left(Arr, Left + 1, Right, Val);
skip_duplicates_left(_Arr, Left, _Right, _Val) ->
    Left.

skip_duplicates_right(Arr, Left, Right, Val) when Left < Right andalso array:get(Right, Arr) == Val ->
    skip_duplicates_right(Arr, Left, Right - 1, Val);
skip_duplicates_right(_Arr, _Left, Right, _Val) ->
    Right.