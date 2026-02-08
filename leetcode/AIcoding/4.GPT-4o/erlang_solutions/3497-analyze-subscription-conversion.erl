-module(solution).
-export([analyze_subscription_conversion/2]).

analyze_subscription_conversion/2 ->
    [X1, X2] = lists:map(fun lists:sum/1, [lists:map(fun(X) -> X end, lists:filter(fun({_,_,S}) -> S == 1 end, A)),
                                                  lists:map(fun(X) -> X end, lists:filter(fun({_,_,S}) -> S == 0 end, A))]),
     {X1, X2} = {lists:sum(lists:map(fun({_,_,S}) -> S end, A)), length(A)},
     if 
        X2 == 0 -> 0.0;
        true -> (X1 / X2) * 100.0
     end.