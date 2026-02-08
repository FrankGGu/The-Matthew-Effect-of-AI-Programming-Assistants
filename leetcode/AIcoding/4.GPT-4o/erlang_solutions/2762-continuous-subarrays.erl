-module(solution).
-export([count_subarrays/1]).

count_subarrays(List) ->
    N = length(List),
    {Count, _} = lists:foldl(fun(X, {C, M}) ->
        NewM = max(X, M + X),
        {C + (if NewM > 0 -> 1; true -> 0 end), NewM}
    end, {0, 0}, List),
    Count.