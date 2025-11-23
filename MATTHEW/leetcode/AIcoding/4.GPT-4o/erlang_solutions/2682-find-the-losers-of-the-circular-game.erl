-module(solution).
-export([findLosers/1]).

findLosers(N) ->
    Players = lists:seq(1, N),
    Losers = find_losers(Players, 1, N),
    lists:sort(Losers).

find_losers([], _, _) -> [];
find_losers(Players, Step, Total) ->
    Index = (Step - 1) rem length(Players),
    Player = lists:nth(Index + 1, Players),
    RemainingPlayers = lists:delete(Player, Players),
    NextStep = Step + 1,
    [Player | find_losers(RemainingPlayers, NextStep, Total)].