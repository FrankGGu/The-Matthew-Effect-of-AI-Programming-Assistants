-spec pivot_array(Nums :: [integer()], Pivot :: integer()) -> [integer()].
pivot_array(Nums, Pivot) ->
    partition(Nums, Pivot, [], [], []).

partition([], _Pivot, LessAcc, EqualAcc, GreaterAcc) ->
    lists:reverse(LessAcc) ++ lists:reverse(EqualAcc) ++ lists:reverse(GreaterAcc);
partition([H|T], Pivot, LessAcc, EqualAcc, GreaterAcc) when H < Pivot ->
    partition(T, Pivot, [H|LessAcc], EqualAcc, GreaterAcc);
partition([H|T], Pivot, LessAcc, EqualAcc, GreaterAcc) when H == Pivot ->
    partition(T, Pivot, LessAcc, [H|EqualAcc], GreaterAcc);
partition([H|T], Pivot, LessAcc, EqualAcc, GreaterAcc) when H > Pivot ->
    partition(T, Pivot, LessAcc, EqualAcc, [H|GreaterAcc]).