-module(solution).
-export([min_operations/1]).

min_operations(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Min = 0,
    Max = N - 1,
    Res = 0,
    min_operations(Sorted, 0, N, 0, 0, 0, Res).

min_operations(_, _, _, _, _, _, Res) -> Res;
min_operations(Sorted, L, N, R, Count, Start, Res) ->
    if
        R >= N -> Res;
        true ->
            Current = lists:nth(R + 1, Sorted),
            if
                Current - lists:nth(L + 1, Sorted) < N ->
                    min_operations(Sorted, L, N, R + 1, Count + 1, Start, Res);
                true ->
                    NewRes = Res + (R - L - Count),
                    min_operations(Sorted, L + 1, N, R, 0, L + 1, NewRes)
            end
    end.