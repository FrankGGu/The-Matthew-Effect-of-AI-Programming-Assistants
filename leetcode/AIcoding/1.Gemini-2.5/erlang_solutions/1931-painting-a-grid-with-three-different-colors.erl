-module(solution).
-export([colorTheGrid/2]).

-define(MOD, 1000000007).

generate_patterns(M) ->
    generate_patterns_recursive(M, 0, [], []).

generate_patterns_recursive(M, RowIdx, CurrentPattern, Acc) ->
    if
        RowIdx == M ->
            [lists:reverse(CurrentPattern) | Acc];
        true ->
            Colors = [0, 1, 2],
            lists:foldl(fun(Color, FoldAcc) ->
                if
                    RowIdx == 0 ->
                        generate_patterns_recursive(M, RowIdx + 1, [Color | CurrentPattern], FoldAcc);
                    Color =/= hd(CurrentPattern) ->
                        generate_patterns_recursive(M, RowIdx + 1, [Color | CurrentPattern], FoldAcc);
                    true ->
                        FoldAcc
                end
            end, Acc, Colors)
    end.

is_compatible(P1, P2) ->
    lists:all(fun({C1, C2}) -> C1 =/= C2 end, lists:zip(P1, P2)).

matrix_multiply(A, B) ->
    P = length(hd(A)),

    B_cols = lists:map(fun(J) ->
                           lists:map(fun(Row) -> lists:nth(J+1, Row) end, B)
                       end, lists:seq(0, length(hd(B))-1)),

    lists:map(fun(ARow) ->
        lists:map(fun(BCol) ->
            lists:foldl(fun({AK, BKJ}, Sum) ->
                            (Sum + (AK * BKJ)) rem ?MOD
                        end, 0, lists:zip(ARow, BCol))
        end, B_cols)
    end, A).

matrix_power(M, Power) ->
    N = length(M),
    Identity = lists:map(fun(I) -> lists:map(fun(J) -> if I == J -> 1; true -> 0 end end, lists:seq(0, N-1)) end, lists:seq(0, N-1)),
    matrix_power_recursive(M, Power, Identity).

matrix_power_recursive(_, 0, Acc) -> Acc;
matrix_power_recursive(M, Power, Acc) ->
    if
        Power rem 2 == 1 ->
            matrix_power_recursive(matrix_multiply(M, M), Power div 2, matrix_multiply(Acc, M));
        true ->
            matrix_power_recursive(matrix_multiply(M, M), Power div 2, Acc)
    end.

colorTheGrid(M, N) ->
    Patterns = generate_patterns(M),
    K = length(Patterns),

    if N == 1 ->
        K rem ?MOD;
    true ->
        AdjMatrix = lists:map(fun(P1) ->
            lists:map(fun(P2) ->
                if is_compatible(P1, P2) -> 1; true -> 0 end
            end, Patterns)
        end, Patterns),

        TransitionMatrixPower = matrix_power(AdjMatrix, N - 1),

        V1_col_matrix = lists:map(fun(_) -> [1] end, lists:seq(0, K-1)),

        VN_col_matrix = matrix_multiply(TransitionMatrixPower, V1_col_matrix),

        lists:foldl(fun([X], Sum) -> (Sum + X) rem ?MOD end, 0, VN_col_matrix)
    end.