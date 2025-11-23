-module(permutations_iv).
-export([permute/1]).

permute(Nums) ->
    permute(Nums, []).

permute([], Acc) ->
    [Acc];
permute(Nums, Acc) ->
    lists:foldl(fun(Num, AccList) ->
        case lists:member(Num, Acc) of
            true -> AccList;
            false -> AccList ++ permute(lists:delete(Num, Nums), [Num | Acc])
        end
    end, [], Nums).