-module(solution).
-export([min_absolute_difference/3]).

min_absolute_difference(N, A, K) ->
    ASorted = lists:sort(A),
    min_difference(ASorted, N, K, 1, infinity).

min_difference(_, 0, _, _, Min) -> Min;
min_difference(ASorted, N, K, Start, Min) ->
    case Start < N of
        true ->
            CurrentValue = lists:nth(Start, ASorted),
            NextStart = Start + 1,
            Min1 = min_difference(ASorted, N, K, NextStart, Min),
            Min2 = case Start + K =< N of
                        true -> 
                            Diff = abs(CurrentValue - lists:nth(Start + K, ASorted)),
                            min(Min, Diff);
                        false -> Min
                    end,
            min(Min1, Min2);
        false -> Min
    end.