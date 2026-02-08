-module(permutations).
-export([permute/1]).

permute(Nums) ->
    permute(Nums, []).

permute([], Acc) ->
    [lists:reverse(Acc)];
permute(Nums, Acc) ->
    lists:foldl(fun(Num, AccList) ->
        case lists:member(Num, Acc) of
            true -> AccList;
            false -> 
                permute(lists:delete(Num, Nums), [Num | Acc]) ++ AccList
        end
    end, [], Nums).