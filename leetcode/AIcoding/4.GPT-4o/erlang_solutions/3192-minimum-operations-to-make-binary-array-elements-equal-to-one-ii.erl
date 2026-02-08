-module(solution).
-export([min_operations/1]).

min_operations(BinaryArray) ->
    N = length(BinaryArray),
    Ones = lists:filter(fun(X) -> X =:= 1 end, BinaryArray),
    OnesCount = length(Ones),
    case OnesCount of
        0 -> N;
        _ -> min_operations_helper(BinaryArray, OnesCount, N)
    end.

min_operations_helper(BinaryArray, OnesCount, N) ->
    TotalOps = lists:foldl(fun(X, Acc) ->
        if X =:= 0 -> Acc + 1;
           true -> Acc
        end
    end, 0, BinaryArray),
    min(TotalOps + OnesCount, N).

min(A, B) -> 
    case A < B of
        true -> A;
        false -> B
    end.