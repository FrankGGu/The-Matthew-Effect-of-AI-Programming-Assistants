-module(solution).
-export([earliest_and_latest/1]).

earliest_and_latest(Players) ->
    PlayersList = string:split(Players, ",", all),
    PlayersMap = lists:foldl(fun(Player, Acc) -> 
        [Name | _] = string:split(Player, " "),
        {Name, length(Acc) + 1} ++ Acc
    end, [], PlayersList),
    SortedPlayers = lists:sort(fun({A, _}, {B, _}) -> A < B end, PlayersMap),
    MinRound = 1,
    MaxRound = lists:last(SortedPlayers) ++ 0,
    [MinRound, MaxRound].