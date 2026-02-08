-module(solution).
-export([three_sum/1]).

three_sum(Nums) ->
    SortedNumsList = lists:sort(Nums),
    Len = length(SortedNumsList),
    SortedNums = list_to_tuple(SortedNumsList),
    find_triplets(SortedNums, Len, 0, []).

find_triplets(SortedNums, Len, I, Acc) when I < Len - 2 ->
    N1 = element(I + 1, SortedNums),

    if N1 > 0 ->
        lists:reverse(Acc);
    true ->
        case I > 0 andalso element(I, SortedNums) == N1 of
            true ->
                find_triplets(SortedNums, Len, I + 1, Acc);
            false ->
                Left = I + 1,
                Right = Len - 1,
                NewAcc = two_sum(SortedNums, N1, Left, Right, Acc),
                find_triplets(SortedNums, Len, I + 1, NewAcc)
        end
    end;
find_triplets(_SortedNums, _Len, _I, Acc) ->
    lists:reverse(Acc).

two_sum(SortedNums, N1, Left, Right, Acc) when Left < Right ->
    N2 = element(Left + 1, SortedNums),
    N3 = element(Right + 1, SortedNums),
    Sum = N1 + N2 + N3,

    if Sum == 0 ->
        Triplet = [N1, N2, N3],
        NewAcc1 = [Triplet | Acc],
        NewLeft1 = Left + 1,
        NewRight1 = Right - 1,
        SkipLeft = skip_duplicates_left(SortedNums, NewLeft1, NewRight1, N2),
        SkipRight = skip_duplicates_right(SortedNums, SkipLeft, NewRight1, N3),
        two_sum(SortedNums, N1, SkipLeft, SkipRight, NewAcc1);
    Sum < 0 ->
        two_sum(SortedNums, N1, Left + 1, Right, Acc);
    Sum > 0 ->
        two_sum(SortedNums, N1, Left, Right - 1, Acc)
    end;
two_sum(_SortedNums, _N1, _Left, _Right, Acc) ->
    Acc.

skip_duplicates_left(SortedNums, Left, Right, PrevN2) when Left < Right ->
    N2 = element(Left + 1, SortedNums),
    if N2 == PrevN2 ->
        skip_duplicates_left(SortedNums, Left + 1, Right, PrevN2);
    true ->
        Left
    end;
skip_duplicates_left(_SortedNums, Left, _Right, _PrevN2) ->
    Left.

skip_duplicates_right(SortedNums, Left, Right, PrevN3) when Left < Right ->
    N3 = element(Right + 1, SortedNums),
    if N3 == PrevN3 ->
        skip_duplicates_right(SortedNums, Left, Right - 1, PrevN3);
    true ->
        Right
    end;
skip_duplicates_right(_SortedNums, _Left, Right, _PrevN3) ->
    Right.