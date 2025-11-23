-module(solution).

-export([min_sum_of_lengths/2]).

min_sum_of_lengths(Array, Target) ->
    N = length(Array),
    PrefixSums = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Array),
    PrefixSums1 = lists:reverse(PrefixSums),
    MinLength = lists:foldl(fun(X, Acc) -> min(Acc, X) end, infinity, lists:map(fun(X) -> if X < infinity -> X; true -> infinity end end, PrefixSums)),
    lists:foldl(fun(I, Acc) -> 
                    case lists:nth(I + 1, PrefixSums1) - Target of
                        Sum when Sum >= 0 -> 
                            Length = I + 1 - lists:find(fun(X) -> X >= Sum end, PrefixSums1),
                            min(Acc, Length);
                        _ -> Acc
                    end
                end, MinLength, lists:seq(0, N - 1)).