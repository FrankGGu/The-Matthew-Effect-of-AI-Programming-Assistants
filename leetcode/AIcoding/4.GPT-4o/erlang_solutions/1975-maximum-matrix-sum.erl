-module(solution).
-export([max_matrix_sum/1]).

max_matrix_sum(Matrix) ->
    MaxAbs = lists:max(lists:map(fun(X) -> lists:max(lists:map(fun(Y) -> abs(Y) end, X)) end, Matrix)),
    SumPos = lists:foldl(fun(X, Acc) -> Acc + lists:foldl(fun(Y, Acc1) -> Acc1 + max(Y, 0) end, 0, X) end, 0, Matrix),
    NegCount = lists:foldl(fun(X, Acc) -> Acc + lists:foldl(fun(Y, Acc1) -> if Y < 0 -> Acc1 + 1; true -> Acc1 end end, 0, X) end, 0, Matrix),
    if NegCount rem 2 == 0 -> 
        SumPos; 
    true -> 
        SumPos - 2 * MaxAbs 
    end.