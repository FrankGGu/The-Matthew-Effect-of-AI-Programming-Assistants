-module(solution).
-export([three_sum_multi/3]).

three_sum_multi(A, target, mod) ->
    Count = lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(Y, Acc1) -> 
            lists:foldl(fun(Z, Acc2) -> 
                if 
                    X + Y + Z == target -> 
                        (Acc2 + 1) rem mod;
                    true -> 
                        Acc2 
                end
            end, Acc1, A)
        end, Acc, A)
    end, 0, A),
    Count.