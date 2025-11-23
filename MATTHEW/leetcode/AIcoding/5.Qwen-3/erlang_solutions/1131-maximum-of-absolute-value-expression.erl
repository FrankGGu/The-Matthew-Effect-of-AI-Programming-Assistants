-module(max_of_absolute_value).
-export([max_abs_expr/1]).

max_abs_expr(Numbers) ->
    N = length(Numbers),
    Max = -infinity,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I /= J ->
                Val = abs((lists:nth(I+1, Numbers) - lists:nth(J+1, Numbers)) + (I - J)),
                if Val > Acc2 -> Val;
                   true -> Acc2
                end;
            true -> Acc2
            end
        end, Acc, lists:seq(0, N-1))
    end, Max, lists:seq(0, N-1)).