-module(solution).
-export([sum_of_absolute_differences/1]).

sum_of_absolute_differences(Nums) ->
    N = length(Nums),

    PrefixSumsWithZero = lists:scan(fun(X, Acc) -> X + Acc end, 0, Nums),

    P_prev_values = lists:droplast(PrefixSumsWithZero),

    P_curr_values = lists:drop(1, PrefixSumsWithZero),

    TotalSum = lists:last(P_curr_values),

    Indices = lists:seq(0, N-1),

    CombinedData = lists:zip4(Nums, Indices, P_prev_values, P_curr_values),

    lists:map(fun({Num, Idx, P_prev, P_curr}) ->
        LeftSum = Idx * Num - P_prev,
        RightSum = (TotalSum - P_curr) - (N - 1 - Idx) * Num,
        LeftSum + RightSum
    end, CombinedData).