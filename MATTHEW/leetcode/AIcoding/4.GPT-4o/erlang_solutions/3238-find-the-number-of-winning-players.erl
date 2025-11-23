-module(solution).
-export([find_winning_players/1]).

find_winning_players(plays) ->
    Max = lists:max(plays),
    WinningPlayers = lists:filter(fun(X) -> X * 2 > Max end, plays),
    length(WinningPlayers).