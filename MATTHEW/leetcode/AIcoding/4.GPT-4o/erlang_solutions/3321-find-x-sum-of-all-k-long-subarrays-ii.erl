-module(solution).
-export([x_sum/3]).

x_sum(A, K, X) ->
    N = length(A),
    {Sums, _} = lists:foldl(fun
        (Elem, {SumsAcc, Sum}) ->
            NewSum = Sum + Elem,
            NewSums = lists:sublist(SumsAcc, 1, max(0, length(SumsAcc) - K + 1)),
            {NewSum + lists:sum(NewSums), [Elem | NewSums]}
        end, {[], 0}, A),
    lists:sum(Sums).