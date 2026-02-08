-module(max_sum_of_rectangle_no_larger_than_k).
-export([max_sum_submatrix/2]).

max_sum_submatrix(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Max = -infinity,
    Row = 0,
    loop_rows(Row, Rows, Matrix, Cols, Max, K).

loop_rows(Row, Rows, _, _, Max, _) when Row >= Rows ->
    Max;
loop_rows(Row, Rows, Matrix, Cols, Max, K) ->
    Col = 0,
    loop_cols(Col, Cols, Row, Matrix, Cols, Max, K).

loop_cols(Col, Cols, Row, Matrix, Cols, Max, K) when Col >= Cols ->
    loop_rows(Row + 1, Rows, Matrix, Cols, Max, K);
loop_cols(Col, Cols, Row, Matrix, Cols, Max, K) ->
    Acc = lists:seq(0, Rows - 1),
    Sum = lists:foldl(fun(R, AccIn) ->
                          lists:sublist(hd(lists:nth(R, Matrix)), Col + 1)
                      end, [], Acc),
    Sorted = lists:sort(Sum),
    Res = find_max(Sorted, K, -infinity),
    NewMax = max(Max, Res),
    loop_cols(Col + 1, Cols, Row, Matrix, Cols, NewMax, K).

find_max(_, _, Max) when Max == -infinity ->
    -infinity;
find_max([], _, Max) ->
    Max;
find_max([H | T], K, Max) ->
    case H =< K of
        true ->
            find_max(T, K, max(Max, H));
        false ->
            find_max(T, K, Max)
    end.

prefix_sums(List) ->
    prefix_sums(List, 0, []).

prefix_sums([], _, Acc) ->
    lists:reverse(Acc);
prefix_sums([H | T], Acc, AccList) ->
    prefix_sums(T, Acc + H, [Acc + H | AccList]).

find_max_with_prefix(Sums, K) ->
    Sorted = lists:sort(Sums),
    find_max_with_prefix(Sorted, 0, -infinity, K).

find_max_with_prefix([], _, Max, _) ->
    Max;
find_max_with_prefix([H | T], Prefix, Max, K) ->
    Target = H - K,
    case lists:keymember(Target, 1, lists:zip(T, T)) of
        true ->
            find_max_with_prefix(T, H, max(Max, H - Target), K);
        false ->
            find_max_with_prefix(T, H, Max, K)
    end.