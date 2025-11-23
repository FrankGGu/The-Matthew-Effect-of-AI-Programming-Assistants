-module(solution).
-export([num_subarrays_with_sum/2]).

num_subarrays_with_sum(A, S) ->
    count_subarrays_with_sum(A, S) - count_subarrays_with_sum(A, S - 1).

count_subarrays_with_sum(A, S) ->
    {Count, Sum, Start} = lists:foldl(fun(X, {Count, Sum, Start}) ->
        Sum1 = Sum + X,
        Count1 = if Sum1 == S -> Count + 1; true -> Count end,
        Start1 = if Sum1 >= S -> Start + 1; true -> Start end,
        {Count1, Sum1, Start1}
    end, {0, 0, 0}, A),
    Count.