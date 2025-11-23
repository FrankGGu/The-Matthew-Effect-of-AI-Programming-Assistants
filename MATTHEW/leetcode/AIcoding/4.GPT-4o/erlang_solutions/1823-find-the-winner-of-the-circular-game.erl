-module(solution).
-export([find_winner/2]).

find_winner(N, K) ->
    find_winner_helper(N, K, 0).

find_winner_helper(1, _, Winner) ->
    Winner + 1;
find_winner_helper(N, K, Winner) ->
    NewWinner = (Winner + K) rem N,
    find_winner_helper(N - 1, K, NewWinner).