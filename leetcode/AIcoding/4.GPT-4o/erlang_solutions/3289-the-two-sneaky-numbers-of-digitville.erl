-module(solution).
-export([findSneakyNumbers/0]).

findSneakyNumbers() ->
    lists:map(fun(N) -> findSneaky(N, 1, 1, 0) end, [1, 2]).

findSneaky(N, N, X, Acc) when N > 0 ->
    Acc;
findSneaky(N, M, X, Acc) when M < N ->
    NewAcc = if 
        lists:member(M, [2, 3, 5, 7]) -> Acc + 1; 
        true -> Acc 
    end,
    findSneaky(N, M + 1, X, NewAcc);
findSneaky(N, M, X, Acc) -> 
    Acc.