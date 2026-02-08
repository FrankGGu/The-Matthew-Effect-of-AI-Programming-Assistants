-spec largest1BorderedSquare(Grid :: [[integer()]]) -> integer().
largest1BorderedSquare(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Left = lists:duplicate(M, lists:duplicate(N, 0)),
    Top = lists:duplicate(M, lists:duplicate(N, 0)),
    {Left1, Top1} = preprocess(Grid, Left, Top, M, N),
    MaxLen = lists:min([M, N]),
    findMaxSquare(Left1, Top1, M, N, MaxLen, 0).

preprocess(Grid, Left, Top, M, N) ->
    {LeftAcc, TopAcc} = lists:foldl(fun(I, {LAcc, TAcc}) ->
        Row = lists:nth(I + 1, Grid),
        {NewL, NewT} = lists:foldl(fun(J, {LRow, TRow}) ->
            Val = lists:nth(J + 1, Row),
            LVal = if Val == 1 andalso J > 0 -> lists:nth(J, lists:nth(I + 1, LAcc)) + 1; true -> Val end,
            TVal = if Val == 1 andalso I > 0 -> lists:nth(J + 1, lists:nth(I, TAcc)) + 1; true -> Val end,
            {lists:sublist(LRow, J) ++ [LVal] ++ lists:nthtail(J + 1, LRow),
             lists:sublist(TRow, J) ++ [TVal] ++ lists:nthtail(J + 1, TRow)}
        end, {lists:nth(I + 1, LAcc), lists:nth(I + 1, TAcc)}, lists:seq(0, N - 1)),
        {lists:sublist(LAcc, I) ++ [NewL] ++ lists:nthtail(I + 1, LAcc),
         lists:sublist(TAcc, I) ++ [NewT] ++ lists:nthtail(I + 1, TAcc)}
    end, {Left, Top}, lists:seq(0, M - 1)),
    {LeftAcc, TopAcc}.

findMaxSquare(Left, Top, M, N, Len, Max) when Len > 0 ->
    PossibleMax = findPossibleMax(Left, Top, M, N, Len),
    if PossibleMax > Max -> findMaxSquare(Left, Top, M, N, Len - 1, PossibleMax);
       true -> findMaxSquare(Left, Top, M, N, Len - 1, Max)
    end;
findMaxSquare(_, _, _, _, _, Max) ->
    Max * Max.

findPossibleMax(Left, Top, M, N, Len) ->
    lists:foldl(fun(I, Acc) ->
        if I + Len > M -> Acc;
           true ->
                lists:foldl(fun(J, InnerAcc) ->
                    if J + Len > N -> InnerAcc;
                       true ->
                            TopLeft = lists:nth(J + 1, lists:nth(I + 1, Left)) >= Len,
                            TopRight = lists:nth(J + Len, lists:nth(I + 1, Left)) >= Len,
                            BottomLeft = lists:nth(J + 1, lists:nth(I + Len, Top)) >= Len,
                            BottomRight = lists:nth(J + 1, lists:nth(I + Len, Left)) >= Len,
                            if TopLeft andalso TopRight andalso BottomLeft andalso BottomRight -> Len;
                               true -> InnerAcc
                            end
                    end
                end, Acc, lists:seq(0, N - Len))
        end
    end, 0, lists:seq(0, M - Len)).