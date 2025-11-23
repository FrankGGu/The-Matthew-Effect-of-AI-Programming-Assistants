-module(minimum_absolute_difference_sliding_submatrix).
-export([solve/3]).

solve(Matrix, K, X) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    MinDiff = lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, Acc2) ->
                    Submatrix = get_submatrix(Matrix, I, J, K),
                    Sorted = lists:sort(Submatrix),
                    Diff = find_min_diff(Sorted, X),
                    min(Acc2, Diff)
                end,
                Acc,
                lists:seq(0, M - K)
            )
        end,
        infinity,
        lists:seq(0, N - K)
    ).

get_submatrix(Matrix, I, J, K) ->
    lists:flatten([
        lists:sublist(lists:nth(RowIndex, Matrix), J + 1, K)
        || RowIndex <- lists:seq(I + 1, I + K)
    ]).

find_min_diff(Sorted, X) ->
    lists:foldl(
        fun(Elem, {Min, Prev}) ->
            Diff = abs(Elem - X),
            case Prev of
                none ->
                    {Diff, Elem};
                _ ->
                    {min(Min, Diff), Elem}
            end
        end,
        {infinity, none},
        Sorted
    ).