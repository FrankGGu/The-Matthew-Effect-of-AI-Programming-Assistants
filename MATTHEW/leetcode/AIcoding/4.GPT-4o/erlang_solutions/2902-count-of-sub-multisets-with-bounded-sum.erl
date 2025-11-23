-module(solution).
-export([countSubsets/2]).

countSubsets(N, K) ->
    Sum = lists:sum(N),
    Max = lists:max(N),
    DP = lists:duplicate(Sum + 1, lists:duplicate(Max + 1, 0)),
    DP = lists:foldl(fun(X, Acc) ->
        lists:foldl(fun(I, A) ->
            lists:foldl(fun(J, A1) ->
                if
                    I + J =< Sum -> 
                        lists:update_element(I + J, lists:update_element(J, A1, lists:nth(J, A1) + lists:nth(I, A1)), lists:nth(I + J, A1) + 1);
                    true -> A1
                end
            end, A, lists:seq(0, Max))
        end, Acc, lists:seq(1, X)
    end, lists:map(fun(_) -> 1 end, DP), N),
    lists:nth(K + 1, lists:nth(0, DP)).