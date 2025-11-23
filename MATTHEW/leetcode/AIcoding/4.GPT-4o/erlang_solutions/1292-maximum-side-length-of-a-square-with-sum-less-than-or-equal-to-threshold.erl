-module(solution).
-export([max_side_length/2]).

max_side_length(Matrix, Threshold) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    PrefixSum = calculate_prefix_sum(Matrix),
    MaxSide = lists:max(lists:seq(0, min(N, M))),
    find_max_side(PrefixSum, N, M, Threshold, MaxSide).

calculate_prefix_sum(Matrix) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    PrefixSum = lists:map(fun(Row) -> lists:foldl(fun(X, Acc) -> Acc + X end, 0, Row) end, Matrix),
    lists:map(fun(I) -> lists:map(fun(J) -> sum_prefix(PrefixSum, I, J) end, lists:seq(1, M)) end, lists:seq(1, N)).

sum_prefix(PrefixSum, I, J) ->
    Sum = lists:foldl(fun(Acc, X) -> Acc + X end, 0, lists:sublist(PrefixSum, 1, I)),
    lists:foldl(fun(Row, Acc) -> Acc + lists:nth(J, Row) end, 0, lists:sublist(PrefixSum, 1, I)) - Sum.

find_max_side(_, _, _, _, 0) -> 0;
find_max_side(PrefixSum, N, M, Threshold, Side) ->
    if
        check_square(PrefixSum, Side, Threshold) ->
            Side;
        true ->
            find_max_side(PrefixSum, N, M, Threshold, Side - 1)
    end.

check_square(PrefixSum, Side, Threshold) ->
    N = length(PrefixSum),
    M = length(hd(PrefixSum)),
    lists:foldl(fun(I, Acc) -> Acc orelse check_square_position(PrefixSum, I, Side, Threshold) end, false, lists:seq(1, N - Side + 1)).

check_square_position(PrefixSum, I, Side, Threshold) ->
    J = lists:seq(1, length(hd(PrefixSum)) - Side + 1),
    Sum = lists:foldl(fun(JIndex, Acc) -> Acc + (get_square_sum(PrefixSum, I, JIndex, Side)) end, 0, J),
    Sum =< Threshold.

get_square_sum(PrefixSum, I, J, Side) ->
    A = I + Side - 1,
    B = J + Side - 1,
    Sum = sum_region(PrefixSum, A, B) - sum_region(PrefixSum, I - 1, B) - sum_region(PrefixSum, A, J - 1) + sum_region(PrefixSum, I - 1, J - 1),
    Sum.

sum_region(PrefixSum, I, J) ->
    if
        I =< 0 orelse J =< 0 -> 0;
        true -> lists:nth(J, lists:nth(I, PrefixSum))
    end.