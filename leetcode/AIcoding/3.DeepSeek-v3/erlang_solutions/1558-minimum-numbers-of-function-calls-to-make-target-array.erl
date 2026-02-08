-module(solution).
-export([min_operations/1]).

min_operations(Nums) ->
    min_operations(Nums, 0, 0).

min_operations([], Add, MaxMul) ->
    Add + MaxMul;
min_operations([Num | Rest], Add, MaxMul) ->
    {A, M} = count_ops(Num, 0, 0),
    min_operations(Rest, Add + A, max(MaxMul, M)).

count_ops(0, Add, Mul) ->
    {Add, Mul};
count_ops(Num, Add, Mul) when Num rem 2 == 1 ->
    count_ops(Num - 1, Add + 1, Mul);
count_ops(Num, Add, Mul) ->
    count_ops(Num div 2, Add, Mul + 1).