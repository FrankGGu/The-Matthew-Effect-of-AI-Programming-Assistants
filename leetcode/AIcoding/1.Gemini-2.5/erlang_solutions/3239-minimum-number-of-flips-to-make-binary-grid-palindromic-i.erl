-module(solution).
-export([min_flips/1]).

-spec min_flips(Grid :: [[integer()]]) -> integer().
min_flips(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    min_flips_recursive(Grid, M, N, 0, 0, 0).

min_flips_recursive(_Grid, M, N, R, _C, Acc) when R >= (M + 1) div 2 ->
    Acc;
min_flips_recursive(Grid, M, N, R, C, Acc) when C >= (N + 1) div 2 ->
    min_flips_recursive(Grid, M, N, R + 1, 0, Acc);
min_flips_recursive(Grid, M, N, R, C, Acc) ->
    Val1 = get_val(Grid, R, C),
    Val2 = get_val(Grid, R, N - 1 - C),
    Val3 = get_val(Grid, M - 1 - R, C),
    Val4 = get_val(Grid, M - 1 - R, N - 1 - C),

    CurrentFlips =
        if
            R == M - 1 - R andalso C == N - 1 - C -> % Center cell (M, N both odd)
                0;
            R == M - 1 - R -> % Center row, non-center column (M odd, N even or odd)
                % Cells are (R, C) and (R, N-1-C)
                % Val1 and Val2 are the two distinct cells to consider
                if
                    Val1 == Val2 -> 0;
                    true -> 1
                end;
            C == N - 1 - C -> % Center column, non-center row (M even or odd, N odd)
                % Cells are (R, C) and (M-1-R, C)
                % Val1 and Val3 are the two distinct cells to consider
                if
                    Val1 == Val3 -> 0;
                    true -> 1
                end;
            true -> % Four distinct cells (or two distinct pairs)
                % Val1, Val2, Val3, Val4 are the four cells to consider
                Zeros = count_zeros([Val1, Val2, Val3, Val4]),
                Ones = 4 - Zeros,
                min(Zeros, Ones)
        end,
    min_flips_recursive(Grid, M, N, R, C + 1, Acc + CurrentFlips).

get_val(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

count_zeros(List) ->
    lists:foldl(fun(X, Acc) -> if X == 0 -> Acc + 1; true -> Acc end end, 0, List).