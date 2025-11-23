-module(solution).
-export([bicycleRace/2]).

bicycleRace(teams, d) ->
    TeamsList = lists:map(fun({Speed, Strength}) ->
        {Speed, Strength, round(d / Speed)} 
    end, teams),
    lists:sort(fun({_, Strength1, _}, {_, Strength2, _}) -> Strength1 > Strength2 end, TeamsList).