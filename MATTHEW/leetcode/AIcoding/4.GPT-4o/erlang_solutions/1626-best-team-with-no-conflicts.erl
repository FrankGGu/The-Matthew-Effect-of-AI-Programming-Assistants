-module(solution).
-export([best_team/2]).

best_team(Points, Skills) ->
    Players = lists:zip(Points, Skills),
    SortedPlayers = lists:sort(fun({P1, S1}, {P2, S2}) -> 
        case P1 =:= P2 of
            true -> S1 < S2;
            false -> P1 > P2
        end 
    end, Players),
    best_team_helper(SortedPlayers, 0, 0).

best_team_helper([], AccPoints, _) -> AccPoints;
best_team_helper([{P, S} | Rest], AccPoints, LastSkill) ->
    if
        S < LastSkill -> 
            best_team_helper(Rest, AccPoints, LastSkill);
        true -> 
            best_team_helper(Rest, AccPoints + P, S)
    end.