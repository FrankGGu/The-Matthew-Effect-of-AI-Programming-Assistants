-module(solution).
-export([getMaximumConsecutive/1]).

getMaximumConsecutive(Coins) ->
    get_max_consecutive(Coins, 1).

get_max_consecutive([], Max) ->
    Max;
get_max_consecutive([H | T], Max) when H > Max ->
    get_max_consecutive(T, Max + 1);
get_max_consecutive([H | T], Max) when H =< Max ->
    get_max_consecutive(T, Max).