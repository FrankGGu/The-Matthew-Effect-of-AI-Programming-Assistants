-module(solution).
-export([num_pairs/2]).

num_pairs(Nums, Target) ->
    Count = maps:from_list([{N, 0} || N <- Nums]),
    lists:foldl(fun(N, Acc) ->
        case maps:is_key(Target - N, Count) of
            true -> Acc + maps:get(Target - N, Count);
            false -> Acc
        end
    end, 0, Nums).

num_pairs(Nums, Target, _) ->
    Count = maps:from_list([{N, 0} || N <- Nums]),
    lists:foldl(fun(N, Acc) ->
        case maps:is_key(Target - N, Count) of
            true -> Acc + maps:get(Target - N, Count);
            false -> Acc
        end
    end, 0, Nums).