-module(solution).
-export([num_subarrays/2]).

num_subarrays(A, B) ->
    N = length(A),
    {Count, _} = lists:foldl(fun(X, {C, P}) ->
        P1 = if X == hd(B) -> P + 1; true -> 0 end,
        {C + P1, P1}
    end, {0, 0}, A),
    Count.