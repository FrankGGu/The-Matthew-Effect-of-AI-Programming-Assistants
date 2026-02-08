-spec matrix_block_sum(Matrix :: [[integer()]], K :: integer()) -> [[integer()]].
matrix_block_sum(Matrix, K) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    Prefix = lists:duplicate(M + 1, lists:duplicate(N + 1, 0)),
    Prefix1 = compute_prefix(Matrix, Prefix, 1, M, N),
    Result = lists:duplicate(M, lists:duplicate(N, 0)),
    compute_result(Matrix, Prefix1, Result, K, 1, M, N).

compute_prefix(_, Prefix, I, M, _) when I > M -> Prefix;
compute_prefix(Matrix, Prefix, I, M, N) ->
    Row = lists:nth(I, Matrix),
    NewPrefix = compute_row_prefix(Row, Prefix, I, 1, N),
    compute_prefix(Matrix, NewPrefix, I + 1, M, N).

compute_row_prefix(_, Prefix, _, J, N) when J > N -> Prefix;
compute_row_prefix(Row, Prefix, I, J, N) ->
    Val = lists:nth(J, Row),
    PrevRow = lists:nth(I, Prefix),
    PrevCol = lists:nth(I + 1, Prefix),
    PrevBoth = lists:nth(I, Prefix),
    NewVal = Val + lists:nth(J, PrevRow) + lists:nth(J + 1, PrevCol) - lists:nth(J, PrevBoth),
    NewPrefix = update_prefix(Prefix, I + 1, J + 1, NewVal),
    compute_row_prefix(Row, NewPrefix, I, J + 1, N).

update_prefix(Prefix, I, J, Val) ->
    Row = lists:nth(I, Prefix),
    NewRow = set_nth(Row, J, Val),
    set_nth(Prefix, I, NewRow).

set_nth(List, 1, Val) -> [Val | tl(List)];
set_nth([H | T], N, Val) when N > 1 -> [H | set_nth(T, N - 1, Val)].

compute_result(_, _, Result, _, I, M, _) when I > M -> Result;
compute_result(Matrix, Prefix, Result, K, I, M, N) ->
    NewResult = compute_row_result(Matrix, Prefix, Result, K, I, 1, N),
    compute_result(Matrix, Prefix, NewResult, K, I + 1, M, N).

compute_row_result(_, _, Result, _, _, J, N) when J > N -> Result;
compute_row_result(Matrix, Prefix, Result, K, I, J, N) ->
    R1 = max(1, I - K),
    C1 = max(1, J - K),
    R2 = min(length(Matrix), I + K),
    C2 = min(length(hd(Matrix)), J + K),
    Sum = get_sum(Prefix, R1, C1, R2, C2),
    NewResult = update_result(Result, I, J, Sum),
    compute_row_result(Matrix, Prefix, NewResult, K, I, J + 1, N).

get_sum(Prefix, R1, C1, R2, C2) ->
    A = lists:nth(R1, lists:nth(C1, Prefix)),
    B = lists:nth(R1, lists:nth(C2 + 1, Prefix)),
    C = lists:nth(R2 + 1, lists:nth(C1, Prefix)),
    D = lists:nth(R2 + 1, lists:nth(C2 + 1, Prefix)),
    D - B - C + A.

update_result(Result, I, J, Val) ->
    Row = lists:nth(I, Result),
    NewRow = set_nth(Row, J, Val),
    set_nth(Result, I, NewRow).