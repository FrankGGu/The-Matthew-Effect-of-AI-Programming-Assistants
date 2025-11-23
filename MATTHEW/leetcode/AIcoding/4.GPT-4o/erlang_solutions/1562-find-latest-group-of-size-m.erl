-module(solution).
-export([find_latest_group/2]).

find_latest_group(N, M) ->
    Groups = lists:foldl(fun(X, Acc) ->
        case lists:keyfind(X, 1, Acc) of
            false -> [{X, 1} | Acc];
            {X, Count} -> [{X, Count + 1} | lists:keydelete(X, 1, Acc)]
        end
    end, [], lists:seq(1, N)),
    Groups1 = lists:filter(fun({_, Count}) -> Count == M end, Groups),
    case lists:map(fun({X, _}) -> X end, Groups1) of
        [] -> [];
        L -> lists:max(L)
    end.