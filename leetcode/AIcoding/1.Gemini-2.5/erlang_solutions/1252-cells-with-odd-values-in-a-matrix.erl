-module(solution).
-export([oddCells/3]).

oddCells(M, N, Indices) ->
    RowCounts = array:new(M, {default, 0}),
    ColCounts = array:new(N, {default, 0}),

    {FinalRowCounts, FinalColCounts} = lists:foldl(
        fun([R, C], {CurrentRowCounts, CurrentColCounts}) ->
            NewRowCounts = array:set(R, array:get(R, CurrentRowCounts) + 1, CurrentRowCounts),
            NewColCounts = array:set(C, array:get(C, CurrentColCounts) + 1, CurrentColCounts),
            {NewRowCounts, NewColCounts}
        end,
        {RowCounts, ColCounts},
        Indices
    ),

    OddRows = count_parity(FinalRowCounts, M, odd),
    EvenRows = M - OddRows,

    OddCols = count_parity(FinalColCounts, N, odd),
    EvenCols = N - OddCols,

    OddRows * EvenCols + EvenRows * OddCols.

count_parity(Arr, Size, Parity) ->
    count_parity_recursive(0, Size, Arr, Parity, 0).

count_parity_recursive(Index, Size, Arr, Parity, Acc) when Index < Size ->
    Value = array:get(Index, Arr),
    IsOdd = (Value rem 2 == 1),
    NewAcc = case Parity of
                 odd when IsOdd -> Acc + 1;
                 even when not IsOdd -> Acc + 1;
                 _ -> Acc
             end,
    count_parity_recursive(Index + 1, Size, Arr, Parity, NewAcc);
count_parity_recursive(_Index, _Size, _Arr, _Parity, Acc) ->
    Acc.