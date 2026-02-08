-module(solution).
-export([findTheWinner/2]).

findTheWinner(N, K) ->
    josephus(N, K) + 1.

josephus(1, _K) ->
    0;
josephus(N, K) ->
    (josephus(N - 1, K) + K) rem N.