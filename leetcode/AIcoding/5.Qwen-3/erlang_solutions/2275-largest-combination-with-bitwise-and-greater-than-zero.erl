-module(largest_combination_with_bitwise_and_greater_than_zero).
-export([max_score/1]).

max_score(Numbers) ->
    Max = lists:foldl(fun(N, Acc) -> max(Acc, N) end, 0, Numbers),
    Count = lists:foldl(fun(N, Acc) -> 
        lists:foldl(fun(Bit, A) -> 
            case (N band (1 bsl Bit)) of
                0 -> A;
                _ -> A + 1
            end
        end, 0, lists:seq(0, 30))
    end, [], Numbers),
    lists:foldl(fun(C, Acc) -> max(Acc, C) end, 0, Count).