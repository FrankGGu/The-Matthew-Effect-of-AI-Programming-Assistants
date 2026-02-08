-module(ice_breaking_game).
-export([find_last_man_standing/2]).

find_last_man_standing(N, K) ->
    find_last_man_standing(N, K, 1).

find_last_man_standing(1, _, Result) ->
    Result;
find_last_man_standing(N, K, Result) ->
    NewResult = (Result + K - 1) rem N,
    find_last_man_standing(N - 1, K, NewResult + 1).