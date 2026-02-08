-module(solution).
-export([max_abs_value_expr/2]).

max_abs_value_expr(Arr1, Arr2) ->
    N = length(Arr1),
    Indices = lists:seq(0, N - 1),
    Combined = lists:zip3(Arr1, Arr2, Indices),

    SignCombinations = [
        {1, 1, 1}, {1, 1, -1}, {1, -1, 1}, {1, -1, -1},
        {-1, 1, 1}, {-1, 1, -1}, {-1, -1, 1}, {-1, -1, -1}
    ],

    lists:foldl(fun(Signs, MaxOverall) ->
        calculate_max_diff(Signs, Combined, MaxOverall)
    end, 0, SignCombinations).

calculate_max_diff({S1, S2, S3}, Combined, CurrentMaxOverall) ->
    Values = lists:map(fun({A1, A2, Idx}) ->
        S1 * A1 + S2 * A2 + S3 * Idx
    end, Combined),

    [H|_T] = Values,
    {MaxVal, MinVal} = lists:foldl(fun(V, {CurrentMax, CurrentMin}) ->
        {max(V, CurrentMax), min(V, CurrentMin)}
    end, {H, H}, Values),

    Diff = MaxVal - MinVal,
    max(CurrentMaxOverall, Diff).