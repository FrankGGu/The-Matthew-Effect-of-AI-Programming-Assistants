-module(rank_teams_by_votes).
-export([rank_teams/2]).

rank_teams(Votes, K) ->
    Map = lists:foldl(fun(Team, Acc) -> 
        maps:update_with(Team, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{}, Votes),
    Sorted = lists:sort(fun(A, B) ->
        AVotes = maps:get(A, Map),
        BVotes = maps:get(B, Map),
        if
            AVotes == BVotes -> A < B;
            true -> AVotes > BVotes
        end
    end, maps:keys(Map)),
    lists:sublist(Sorted, K).