-module(solution).
-export([max_sum_subarrays/2]).

max_sum_subarrays(N, M) ->
    {ok, Input} = io:get_line(""),
    List = string:split(Input, " ", all),
    A = lists:map(fun(X) -> list_to_integer(X) end, List),
    max_sum(A, M).

max_sum(A, M) ->
    N = length(A),
    Sums = lists:duplicate(N + 1, 0),
    MaxSum = lists:foldl(fun(X, Acc) -> Acc + X end, 0, lists:sublist(A, 0, M)),
    lists:foldl(fun(X, Acc) -> 
        NewSum = Acc + X,
        Sums = lists:sublist(Sums, 1),
        lists:append(Sums, [NewSum])
    end, MaxSum, lists:sublist(A, M, N - M)),
    lists:max(Sums).