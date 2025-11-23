-module(partition_array_into_two_arrays_to_minimize_sum_difference).
-export([minimize_sum_difference/1]).

minimize_sum_difference(Nums) ->
    Sum = lists:sum(Nums),
    N = length(Nums),
    Target = Sum div 2,
    Max = erlang:integer_to_list(Target),
    {_, Result} = lists:foldl(fun(X, {Acc, DP}) ->
        NewDP = lists:seq(0, Target),
        lists:foldl(fun(I, Acc2) ->
            case lists:nth(I + 1, DP) of
                1 when I >= X ->
                    lists:sublist(Acc2, I) ++ [1] ++ lists:sublist(Acc2, I+1, Target - I);
                _ ->
                    lists:sublist(Acc2, I) ++ [lists:nth(I + 1, DP)] ++ lists:sublist(Acc2, I+1, Target - I)
            end
        end, NewDP, lists:seq(0, Target))
    end, {0, [1 | lists:seq(0, Target)]}, Nums),
    lists:foldl(fun(I, Acc) ->
        if lists:nth(I + 1, Result) == 1 -> 
            min(Acc, abs(Sum - 2 * I));
            true -> Acc
        end
    end, infinity, lists:seq(0, Target)).

min(A, B) when A < B -> A;
min(_, B) -> B.