-spec spiral_order(Matrix :: [[integer()]]) -> [integer()].
spiral_order(Matrix) ->
    case Matrix of
        [] -> [];
        _ ->
            M = length(Matrix),
            N = length(hd(Matrix)),
            spiral(Matrix, 0, 0, M - 1, N - 1, [])
    end.

spiral(Matrix, R1, C1, R2, C2, Acc) when R1 > R2 orelse C1 > C2 ->
    lists:reverse(Acc);
spiral(Matrix, R1, C1, R2, C2, Acc) ->
    Acc1 = lists:foldl(fun(C, A) -> [lists:nth(C + 1, lists:nth(R1 + 1, Matrix)) | A] end, Acc, lists:seq(C1, C2)),
    Acc2 = if R1 < R2 -> 
                lists:foldl(fun(R, A) -> [lists:nth(C2 + 1, lists:nth(R + 1, Matrix)) | A] end, Acc1, lists:seq(R1 + 1, R2));
              true -> Acc1
           end,
    Acc3 = if R1 < R2 andalso C1 < C2 ->
                lists:foldl(fun(C, A) -> [lists:nth(C + 1, lists:nth(R2 + 1, Matrix)) | A] end, Acc2, lists:seq(C2 - 1, C1, -1));
              true -> Acc2
           end,
    Acc4 = if C1 < C2 andalso R1 < R2 - 1 ->
                lists:foldl(fun(R, A) -> [lists:nth(C1 + 1, lists:nth(R + 1, Matrix)) | A] end, Acc3, lists:seq(R2 - 1, R1 + 1, -1));
              true -> Acc3
           end,
    spiral(Matrix, R1 + 1, C1 + 1, R2 - 1, C2 - 1, Acc4).