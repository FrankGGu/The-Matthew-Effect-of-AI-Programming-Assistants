-spec kth_largest_value(Matrix :: [[integer()]], K :: integer()) -> integer().
kth_largest_value(Matrix, K) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    Xor = lists:duplicate(M, lists:duplicate(N, 0)),
    Acc = [],
    {FinalXor, _} = lists:foldl(fun(I, {XorAcc, AccAcc}) ->
        Row = lists:nth(I + 1, Matrix),
        {NewXorRow, NewAcc} = lists:foldl(fun(J, {XorRow, AccIn}) ->
            XorVal = if
                I =:= 0 andalso J =:= 0 -> lists:nth(J + 1, Row);
                I =:= 0 -> lists:nth(J + 1, XorRow) bxor lists:nth(J + 1, Row);
                J =:= 0 -> lists:nth(J + 1, lists:nth(I, XorAcc)) bxor lists:nth(J + 1, Row);
                true -> lists:nth(J + 1, lists:nth(I, XorAcc)) bxor
                       lists:nth(J, lists:nth(I + 1, XorAcc))) bxor
                       lists:nth(J + 1, Row) bxor
                       lists:nth(J, XorRow)
            end,
            NewXorRow1 = setelement(J + 1, XorRow, XorVal),
            {NewXorRow1, [XorVal | AccIn]}
        end, {lists:nth(I + 1, XorAcc), AccAcc}, lists:seq(0, N - 1)),
        NewXorAcc = setelement(I + 1, XorAcc, NewXorRow),
        {NewXorAcc, NewAcc}
    end, {Xor, Acc}, lists:seq(0, M - 1)),
    Sorted = lists:reverse(lists:sort(FinalXor)),
    lists:nth(K, Sorted).