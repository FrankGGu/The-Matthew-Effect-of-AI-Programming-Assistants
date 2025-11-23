-module(solution).
-export([max_k_sum_pairs/2]).

max_k_sum_pairs(List, K) ->
    Pairs = lists:foldl(fun(X, Acc) ->
        case lists:keyfind(K - X, 1, Acc) of
            false -> [{X, 0} | Acc];
            {Y, _} -> [{X, Y} | lists:keydelete(Y, 1, Acc)]
        end
    end, [], List),
    length(Pairs).