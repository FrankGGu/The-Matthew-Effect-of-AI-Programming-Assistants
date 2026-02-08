-spec spiral_order(Matrix :: [[integer()]]) -> [integer()].
spiral_order(Matrix) ->
    case Matrix of
        [] -> [];
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            spiral(Matrix, 0, Rows - 1, 0, Cols - 1, [])
    end.

spiral(_, Top, Bottom, _, _, Acc) when Top > Bottom -> lists:reverse(Acc);
spiral(_, _, _, Left, Right, Acc) when Left > Right -> lists:reverse(Acc);
spiral(Matrix, Top, Bottom, Left, Right, Acc) ->
    % Top row
    Acc1 = lists:foldl(fun(C, A) -> [lists:nth(C + 1, lists:nth(Top + 1, Matrix)) | A] end, Acc, lists:seq(Left, Right)),
    % Right column
    Acc2 = case Top + 1 =< Bottom of
        true ->
            lists:foldl(fun(R, A) -> [lists:nth(Right + 1, lists:nth(R + 1, Matrix)) | A] end, Acc1, lists:seq(Top + 1, Bottom));
        false -> Acc1
    end,
    % Bottom row
    Acc3 = case Top < Bottom andalso Left < Right of
        true ->
            lists:foldl(fun(C, A) -> [lists:nth(C + 1, lists:nth(Bottom + 1, Matrix)) | A] end, Acc2, lists:seq(Right - 1, Left, -1));
        false -> Acc2
    end,
    % Left column
    Acc4 = case Top + 1 =< Bottom - 1 andalso Left < Right of
        true ->
            lists:foldl(fun(R, A) -> [lists:nth(Left + 1, lists:nth(R + 1, Matrix)) | A] end, Acc3, lists:seq(Bottom - 1, Top + 1, -1));
        false -> Acc3
    end,
    spiral(Matrix, Top + 1, Bottom - 1, Left + 1, Right - 1, Acc4).