-module(solution).
-export([main/0]).

main() ->
    Input = [[4, 3, 2, 1, 5],
             [9, 8, 7, 6, 10],
             [14, 13, 12, 11, 15],
             [19, 18, 17, 16, 20]],
    K = 2,
    io:format("~p~n", [min_absolute_diff(Input, K)]).

min_absolute_diff(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MinDiff = infinity,
    min_abs_diff_loop(Rows, Cols, K, Matrix, MinDiff).

min_abs_diff_loop(Row, Col, K, Matrix, Acc) when Row > 0 ->
    min_abs_diff_loop(Row - 1, Col, K, Matrix, Acc);
min_abs_diff_loop(0, Col, K, Matrix, Acc) when Col > 0 ->
    min_abs_diff_loop(0, Col - 1, K, Matrix, Acc);
min_abs_diff_loop(0, 0, _, _, Acc) ->
    Acc;
min_abs_diff_loop(Row, Col, K, Matrix, Acc) ->
    Submatrix = get_submatrix(Matrix, Row, Col, K),
    Sorted = lists:sort(lists:flatten(Submatrix)),
    Diff = find_min_diff(Sorted),
    NewAcc = if
        Diff < Acc -> Diff;
        true -> Acc
    end,
    min_abs_diff_loop(Row, Col - 1, K, Matrix, NewAcc).

get_submatrix(Matrix, Row, Col, K) ->
    lists:sublist(Matrix, Row, K) -- lists:sublist(Matrix, Row + K, K).

find_min_diff(List) ->
    find_min_diff(List, hd(List), infinity).

find_min_diff([], _, Acc) ->
    Acc;
find_min_diff([H | T], Prev, Acc) ->
    Diff = abs(H - Prev),
    NewAcc = if
        Diff < Acc -> Diff;
        true -> Acc
    end,
    find_min_diff(T, H, NewAcc).