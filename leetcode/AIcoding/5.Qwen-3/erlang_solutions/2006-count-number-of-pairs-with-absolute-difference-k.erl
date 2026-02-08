-module(solution).
-export([count_diff_k/2]).

count_diff_k(Nums, K) ->
    Count = maps:from_list([{N, 0} || N <- Nums]),
    lists:foldl(fun(N, Acc) -> 
        case maps:is_key(N + K, Count) of
            true -> Acc + maps:get(N + K, Count);
            false -> Acc
        end
    end, 0, Nums).