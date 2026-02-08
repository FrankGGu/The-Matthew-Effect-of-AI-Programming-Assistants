-module(solution).
-export([count_unique_xor_triplets/1]).

count_unique_xor_triplets(List) ->
    UniqueXors = lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(Y, Acc2) -> 
            lists:foldl(fun(Z, Acc3) -> 
                case lists:member(X bxor Y bxor Z, Acc3) of 
                    true -> Acc3; 
                    false -> [X bxor Y bxor Z | Acc3] 
                end 
            end, Acc2, lists:filter(fun(W) -> W =/= X, lists:filter(fun(V) -> V =/= Y, List)) end) 
        end, Acc, lists:filter(fun(A) -> A =/= X end, List)) 
    end, [], List),
    length(UniqueXors).