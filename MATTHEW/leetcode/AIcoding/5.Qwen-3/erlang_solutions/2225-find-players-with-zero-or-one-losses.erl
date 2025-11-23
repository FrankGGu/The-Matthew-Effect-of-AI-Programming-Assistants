-module(solution).
-export([find_players/1]).

find_players(Results) ->
    Losses = lists:foldl(fun(Result, Acc) ->
        [Win, Lose] = string:split(Result, " "),
        WinInt = list_to_integer(Win),
        LoseInt = list_to_integer(Lose),
        Acc1 = maps:update(WinInt, 1 + maps:get(WinInt, Acc, 0), Acc),
        Acc2 = maps:update(LoseInt, 1 + maps:get(LoseInt, Acc, 0), Acc1),
        Acc2
    end, #{}, Results),
    PlayersWithZeroOrOneLosses = lists:filter(fun({Player, Loss}) ->
        Loss == 0 orelse Loss == 1
    end, maps:to_list(Losses)),
    SortedPlayers = lists:sort([Player || {Player, _} <- PlayersWithZeroOrOneLosses]),
    SortedPlayers.