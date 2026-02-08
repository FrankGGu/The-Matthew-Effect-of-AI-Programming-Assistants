-module(solution).
-export([busy_servers/2]).

busy_servers(N, A) ->
    Requests = lists:foldl(fun(X, Acc) -> 
        case lists:keyfind(X rem N, 1, Acc) of
            {_, Count} -> lists:keyreplace(X rem N, 1, Acc, {X rem N, Count + 1});
            false -> [{X rem N, 1} | Acc]
        end
    end, [], A),
    MaxRequests = lists:max([Count || {_, Count} <- Requests]),
    [Server || {Server, Count} <- Requests, Count =:= MaxRequests].