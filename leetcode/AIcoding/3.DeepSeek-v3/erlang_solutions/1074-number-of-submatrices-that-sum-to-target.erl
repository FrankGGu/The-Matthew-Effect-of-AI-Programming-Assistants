-spec num_submatrix_sum_target(Matrix :: [[integer()]], Target :: integer()) -> integer().
num_submatrix_sum_target(Matrix, Target) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Prefix = lists:duplicate(Rows + 1, lists:duplicate(Cols + 1, 0)),
    UpdatedPrefix = build_prefix(Matrix, Prefix, 1, 1),
    count_submatrices(UpdatedPrefix, Target, Rows, Cols).

build_prefix([], Prefix, _, _) -> Prefix;
build_prefix([Row | Rest], Prefix, I, J) ->
    UpdatedRow = build_row(Row, Prefix, I, J, 0),
    UpdatedPrefix = lists:sublist(Prefix, I - 1) ++ [UpdatedRow] ++ lists:nthtail(I, Prefix),
    build_prefix(Rest, UpdatedPrefix, I + 1, J).

build_row([], Prefix, I, _, _) -> lists:nth(I, Prefix);
build_row([Val | Rest], Prefix, I, J, Sum) ->
    Row = lists:nth(I, Prefix),
    NewSum = Sum + Val,
    UpdatedVal = lists:nth(I - 1, lists:nth(J, Prefix)) + NewSum,
    UpdatedRow = lists:sublist(Row, J - 1) ++ [UpdatedVal] ++ lists:nthtail(J, Row),
    build_row(Rest, Prefix, I, J + 1, NewSum).

count_submatrices(Prefix, Target, Rows, Cols) ->
    Count = 0,
    count_submatrices(Prefix, Target, Rows, Cols, 1, 1, 1, 1, Count).

count_submatrices(_, _, Rows, Cols, R1, _, _, _, Count) when R1 > Rows -> Count;
count_submatrices(Prefix, Target, Rows, Cols, R1, C1, R2, C2, Count) ->
    NewCount = if
        R2 > Rows -> count_submatrices(Prefix, Target, Rows, Cols, R1, C1 + 1, R1, C1 + 1, Count);
        C2 > Cols -> count_submatrices(Prefix, Target, Rows, Cols, R1 + 1, 1, R1 + 1, 1, Count);
        true ->
            Sum = lists:nth(R2, lists:nth(C2, Prefix)) - lists:nth(R1 - 1, lists:nth(C2, Prefix)) - 
                  lists:nth(R2, lists:nth(C1 - 1, Prefix)) + lists:nth(R1 - 1, lists:nth(C1 - 1, Prefix)),
            NewCount1 = if
                Sum =:= Target -> Count + 1;
                true -> Count
            end,
            count_submatrices(Prefix, Target, Rows, Cols, R1, C1, R2, C2 + 1, NewCount1)
    end,
    NewCount.