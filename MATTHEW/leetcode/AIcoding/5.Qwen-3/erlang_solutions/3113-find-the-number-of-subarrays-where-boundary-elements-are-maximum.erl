-module(solution).
-export([num_subarrays/1]).

num_subarrays(Nums) ->
    len = length(Nums),
    count = 0,
    lists:foldl(fun(I, Acc) ->
        Max = lists:max(lists:sublist(Nums, I, len - I + 1)),
        case lists:member(Max, lists:sublist(Nums, I, len - I + 1)) of
            true ->
                Acc + 1;
            false ->
                Acc
        end
    end, count, lists:seq(1, len)).