-module(broken_board_dominoes).
-export([num_tilings/1]).

num_tilings(N) ->
    num_tilings(N, 0, 1, 1).

num_tilings(0, _, _, _) ->
    1;
num_tilings(1, _, _, _) ->
    1;
num_tilings(2, _, _, _) ->
    2;
num_tilings(N, A, B, C) when N > 2 ->
    D = (A + B + 2 * C) rem 1000000007,
    num_tilings(N - 1, B, C, D).