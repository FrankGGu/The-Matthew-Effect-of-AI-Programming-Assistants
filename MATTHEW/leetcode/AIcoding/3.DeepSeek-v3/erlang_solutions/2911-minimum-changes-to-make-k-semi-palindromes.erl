-module(solution).
-export([minimum_changes/2]).

minimum_changes(S, K) ->
    N = length(S),
    DP = lists:duplicate(N + 1, lists:duplicate(K + 1, 1000000)),
    DP1 = lists:foldl(fun(I, Acc) -> 
                          lists:foldl(fun(J, Acc1) -> 
                                          setelement(I + 1, setelement(J + 1, Acc1, 0), Acc1 
                                  end, Acc, lists:seq(0, K)) 
                      end, DP, lists:seq(0, N)),
    Cost = precompute_cost(S),
    lists:foldl(fun(I, Acc) -> 
                    lists:foldl(fun(J, Acc1) -> 
                                    lists:foldl(fun(L, Acc2) -> 
                                                    Min = min(element(L + 1, element(J, Acc2)) + element(L + 1, element(I + 1, Cost)), 
                                                    setelement(I + 1, setelement(J + 1, Acc2, Min), Acc2) 
                                            end, Acc1, lists:seq(1, I - 1)) 
                            end, Acc, lists:seq(1, K)) 
            end, DP1, lists:seq(1, N)),
    element(N + 1, element(K + 1, DP1)).

precompute_cost(S) ->
    N = length(S),
    Cost = lists:duplicate(N + 1, lists:duplicate(N + 1, 0)),
    lists:foldl(fun(I, Acc) -> 
                    lists:foldl(fun(J, Acc1) -> 
                                    Len = J - I + 1,
                                    D = Len div 2,
                                    Changes = lists:foldl(fun(K, Sum) -> 
                                                                case lists:nth(I + K - 1, S) =:= lists:nth(J - K + 1, S) of
                                                                    true -> Sum;
                                                                    false -> Sum + 1
                                                                end 
                                                        end, 0, lists:seq(1, D)),
                                    setelement(J + 1, setelement(I + 1, Acc1, Changes), Acc1) 
                            end, Acc, lists:seq(I, N)) 
            end, Cost, lists:seq(1, N)).