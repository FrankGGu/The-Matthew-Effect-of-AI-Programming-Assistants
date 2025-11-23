-module(solution).
-export([sumSubarrayAverages/1]).

sumSubarrayAverages(A) ->
    N = length(A),
    Sum = lists:sum(A),
    Total = 0,
    sumSubarrayAverages(A, N, 0, 0, Total).

sumSubarrayAverages(_, _, _, _, Total) when Total == 0 ->
    Total;
sumSubarrayAverages(A, N, I, J, Total) ->
    case J < N of
        true ->
            NewTotal = Total + (lists:sum(lists:sublist(A, I+1, J-I+1)) / (J - I + 1)),
            sumSubarrayAverages(A, N, I, J+1, NewTotal);
        false ->
            sumSubarrayAverages(A, N, I+1, I+1, Total)
    end.