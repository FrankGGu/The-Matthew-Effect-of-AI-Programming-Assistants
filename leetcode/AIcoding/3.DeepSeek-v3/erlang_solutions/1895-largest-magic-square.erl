-spec largest_magic_square(Grid :: [[integer()]]) -> integer().
largest_magic_square(Grid) ->
    M = length(Grid),
    case M of
        0 -> 0;
        _ ->
            N = length(hd(Grid)),
            RowSum = lists:duplicate(M, lists:duplicate(N, 0)),
            ColSum = lists:duplicate(M, lists:duplicate(N, 0)),
            DiagSum = lists:duplicate(M, lists:duplicate(N, 0)),
            AntiDiagSum = lists:duplicate(M, lists:duplicate(N, 0)),
            {RowSum1, ColSum1, DiagSum1, AntiDiagSum1} = precompute(Grid, RowSum, ColSum, DiagSum, AntiDiagSum),
            MaxK = min(M, N),
            find_max_k(Grid, RowSum1, ColSum1, DiagSum1, AntiDiagSum1, MaxK, 1)
    end.

precompute(Grid, RowSum, ColSum, DiagSum, AntiDiagSum) ->
    M = length(Grid),
    N = length(hd(Grid)),
    {RowSum1, ColSum1, DiagSum1, AntiDiagSum1} = lists:foldl(fun(I, {RS, CS, DS, ADS}) ->
        lists:foldl(fun(J, {RS1, CS1, DS1, ADS1}) ->
            Val = lists:nth(J+1, lists:nth(I+1, Grid)),
            RS2 = set_val(RS1, I, J, Val + get_val(RS1, I, J-1)),
            CS2 = set_val(CS1, I, J, Val + get_val(CS1, I-1, J)),
            DS2 = set_val(DS1, I, J, Val + get_val(DS1, I-1, J-1)),
            ADS2 = set_val(ADS1, I, J, Val + get_val(ADS1, I-1, J+1)),
            {RS2, CS2, DS2, ADS2}
        end, {RS, CS, DS, ADS}, lists:seq(0, N-1))
    end, {RowSum, ColSum, DiagSum, AntiDiagSum}, lists:seq(0, M-1)),
    {RowSum1, ColSum1, DiagSum1, AntiDiagSum1}.

get_val(Matrix, I, J) ->
    if
        I < 0 orelse J < 0 -> 0;
        true -> lists:nth(J+1, lists:nth(I+1, Matrix))
    end.

set_val(Matrix, I, J, Val) ->
    Row = lists:nth(I+1, Matrix),
    NewRow = set_nth(J+1, Row, Val),
    set_nth(I+1, Matrix, NewRow).

set_nth(1, [_|T], Val) -> [Val|T];
set_nth(N, [H|T], Val) -> [H|set_nth(N-1, T, Val)].

find_max_k(_Grid, _RowSum, _ColSum, _DiagSum, _AntiDiagSum, MaxK, K) when K > MaxK -> K-1;
find_max_k(Grid, RowSum, ColSum, DiagSum, AntiDiagSum, MaxK, K) ->
    case has_magic_square(Grid, RowSum, ColSum, DiagSum, AntiDiagSum, K) of
        true -> find_max_k(Grid, RowSum, ColSum, DiagSum, AntiDiagSum, MaxK, K+1);
        false -> K-1
    end.

has_magic_square(Grid, RowSum, ColSum, DiagSum, AntiDiagSum, K) ->
    M = length(Grid),
    N = length(hd(Grid)),
    lists:any(fun(I) ->
        lists:any(fun(J) ->
            I + K - 1 < M andalso J + K - 1 < N andalso is_magic(Grid, RowSum, ColSum, DiagSum, AntiDiagSum, I, J, K)
        end, lists:seq(0, N-1))
    end, lists:seq(0, M-1)).

is_magic(Grid, RowSum, ColSum, DiagSum, AntiDiagSum, I, J, K) ->
    Sum = get_sum(RowSum, I, J+K-1) - get_sum(RowSum, I, J-1),
    Diag = get_sum(DiagSum, I+K-1, J+K-1) - get_sum(DiagSum, I-1, J-1),
    AntiDiag = get_sum(AntiDiagSum, I+K-1, J) - get_sum(AntiDiagSum, I-1, J+K),
    if
        Diag =/= Sum orelse AntiDiag =/= Sum -> false;
        true ->
            lists:all(fun(X) ->
                RowSum1 = get_sum(RowSum, X, J+K-1) - get_sum(RowSum, X, J-1),
                RowSum1 =:= Sum
            end, lists:seq(I, I+K-1)) andalso
            lists:all(fun(Y) ->
                ColSum1 = get_sum(ColSum, I+K-1, Y) - get_sum(ColSum, I-1, Y),
                ColSum1 =:= Sum
            end, lists:seq(J, J+K-1))
    end.

get_sum(Matrix, I, J) ->
    if
        I < 0 orelse J < 0 -> 0;
        true -> lists:nth(J+1, lists:nth(I+1, Matrix))
    end.