-module(solution).
-export([divide_players/1]).

divide_players(Players) ->
    SortedPlayers = lists:sort(Players),
    calculate_teams(SortedPlayers, 0).

calculate_teams([], Result) -> Result;
calculate_teams([H1, H2 | T], Acc) ->
    calculate_teams(T, Acc + H1 * H2).