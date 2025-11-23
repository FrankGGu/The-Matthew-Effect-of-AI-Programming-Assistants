-module(solution).
-export([maximum_strong_pair_xor/1]).

maximum_strong_pair_xor(List) ->
    Max = lists:max(List),
    lists:foldl(fun(X, Acc) -> 
        case (Max bxor X) > Acc of
            true -> (Max bxor X);
            false -> Acc
        end
    end, 0, List).