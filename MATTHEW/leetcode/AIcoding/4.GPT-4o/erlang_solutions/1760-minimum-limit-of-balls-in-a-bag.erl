-module(solution).
-export([minimum_limit/2]).

minimum_limit(N, A) ->
    low = 1,
    high = lists:max(A),
    minimum_limit_helper(low, high, N, A).

minimum_limit_helper(Low, High, N, A) when Low < High ->
    Mid = (Low + High) div 2,
    Total = lists:foldl(fun(X, Acc) -> Acc + (X + Mid - 1) div Mid end, 0, A),
    if
        Total > N -> minimum_limit_helper(Mid + 1, High, N, A);
        true -> minimum_limit_helper(Low, Mid, N, A)
    end;
minimum_limit_helper(Low, High, _, _) -> Low.