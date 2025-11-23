-module(Solution).
-export([topVotedCandidate/2]).

topVotedCandidate(Votes, K) ->
    {Winners, _} = lists:foldl(fun (V, {Acc, Count}) ->
        NewCount = maps:get(V, Count, 0) + 1,
        NewAcc = if NewCount > maps:get(Acc, 0, 0) -> V; true -> Acc end,
        {NewAcc, maps:put(V, NewCount, Count)}
    end, {undefined, #{}} , Votes),
    lists:nth(K + 1, Winners).