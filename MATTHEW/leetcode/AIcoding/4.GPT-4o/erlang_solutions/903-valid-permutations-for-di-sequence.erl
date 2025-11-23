-module(solution).
-export([numPermsDISeq/1]).

numPermsDISeq(DI) ->
    N = length(DI) + 1,
    M = 1000000007,
    F = lists:foldl(fun(X, Acc) -> Acc * X rem M end, 1, lists:seq(1, N)),
    DP = lists:duplicate(N + 1, lists:duplicate(N + 1, 0)),
    DP:element(1, lists:element(1, DP)) = 1,
    lists:foldl(fun(_, I) ->
        lists:foldl(fun(J, Acc) ->
            if J > I -> 
                Acc + lists:sum(lists:sublist(DP, J + 1, I - J)) rem M;
            true -> 
                Acc
            end
        end, 0, lists:seq(0, I))
    end, DP, lists:seq(1, N)),
    lists:element(N + 1, lists:element(N + 1, DP)).