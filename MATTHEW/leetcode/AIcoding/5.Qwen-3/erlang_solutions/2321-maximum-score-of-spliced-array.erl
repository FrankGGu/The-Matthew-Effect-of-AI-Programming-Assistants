-module(maximum_score_of_spliced_array).
-export([max_sum_after_operation/2]).

max_sum_after_operation(A, B) ->
    Max1 = max_subarray_sum(B, A),
    Max2 = max_subarray_sum(A, B),
    lists:max([Max1, Max2]).

max_subarray_sum(A, B) ->
    N = length(A),
    Diff = lists:zipwith(fun(X, Y) -> X - Y end, A, B),
    Current = 0,
    Max = 0,
    lists:foldl(fun(D, {Cur, MaxSoFar}) ->
        NewCur = max(D, Cur + D),
        NewMax = max(MaxSoFar, NewCur),
        {NewCur, NewMax}
    end, {Current, Max}, Diff),
    case lists:last(Diff) of
        D when D > 0 -> Max;
        _ -> 0
    end.