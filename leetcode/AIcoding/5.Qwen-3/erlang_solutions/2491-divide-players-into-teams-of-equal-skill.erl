-module(solution).
-export([divide_players_into_teams_of_equal_skill/1]).

divide_players_into_teams_of_equal_skill(Players) ->
    Sorted = lists:sort(Players),
    divide(Sorted, []).

divide([], Acc) ->
    lists:reverse(Acc);
divide([A | [B | Rest]], Acc) ->
    Sum = A + B,
    divide(Rest, [{A, B} | Acc]).