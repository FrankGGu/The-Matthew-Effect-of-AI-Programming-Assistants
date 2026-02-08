-module(solution).
-export([minimumSubarrayLength/2]).

minimumSubarrayLength(Nums, K) ->
    N = length(Nums),
    MinLen = N + 1,
    lists:foldl(fun(I, Acc) -> 
        lists:foldl(fun(J, Acc2) -> 
            case (lists:sublist(Nums, I+1, J-I)) of
                Sub when erlang:bitwise_or(lists:foldl(fun(X, Acc3) -> Acc3 bor X end, 0, Sub)) >= K -> 
                    min(J - I, Acc2);
                _ -> Acc2
            end
        end, MinLen, lists:seq(I+1, N-1))
    end, MinLen, lists:seq(0, N-1)).

bitwise_or(List) ->
    lists:foldl(fun(X, Acc) -> Acc bor X end, 0, List).