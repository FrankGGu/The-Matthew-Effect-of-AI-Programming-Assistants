-spec max_matrix_sum(Matrix :: [[integer()]]) -> integer().
max_matrix_sum(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    {NegCount, MinAbs, Sum} = 
        lists:foldl(fun(Row, {NegCnt, Min, S}) ->
            {RowNegCnt, RowMin, RowS} = 
                lists:foldl(fun(X, {Cnt, M, Acc}) ->
                    AbsX = abs(X),
                    NewCnt = if X < 0 -> Cnt + 1; true -> Cnt end,
                    NewMin = min(M, AbsX),
                    NewAcc = Acc + AbsX,
                    {NewCnt, NewMin, NewAcc}
                end, {0, abs(hd(Row)), 0}, Row),
            {NegCnt + RowNegCnt, min(Min, RowMin), S + RowS}
        end, {0, abs(hd(hd(Matrix))), 0}, Matrix),
    if 
        NegCount rem 2 == 0 -> Sum;
        true -> Sum - 2 * MinAbs
    end.