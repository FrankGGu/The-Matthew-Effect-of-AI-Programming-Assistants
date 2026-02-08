-module(solution).
-export([lastRemaining/2]).

lastRemaining(N, M) ->
    josephus_iterative(N, M, 1, 0).

josephus_iterative(N, _M, N, CurrentResult) ->
    CurrentResult;
josephus_iterative(N, M, CurrentN, CurrentResult) when CurrentN < N ->
    NewResult = (CurrentResult + M) rem (CurrentN + 1),
    josephus_iterative(N, M, CurrentN + 1, NewResult).