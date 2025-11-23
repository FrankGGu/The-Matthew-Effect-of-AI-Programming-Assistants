-module(solution).
-export([findKthDigit/2]).

findKthDigit(N, K) ->
    {Number, _} = lists:foldl(fun(_, {Num, Count}) ->
        case Count + length(integer_to_list(Num)) >= K of
            true -> {Num, Count};
            false -> {Num + 1, Count + length(integer_to_list(Num))}
        end
    end, {1, 0}, lists:seq(1, N)),
    KthPosition = K - (Count + 1),
    KthDigit = integer_to_list(Number) ++ [0] ++ [0],
    lists:nth(KthPosition + 1, KthDigit).