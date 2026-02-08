-module(solution).
-export([kthFactor/2]).

kthFactor(N, K) ->
    find_kth_factor(1, N, K).

find_kth_factor(I, N, K_remaining) when I > N ->
    -1;
find_kth_factor(I, N, K_remaining) when N rem I == 0, K_remaining == 1 ->
    I;
find_kth_factor(I, N, K_remaining) when N rem I == 0 ->
    find_kth_factor(I + 1, N, K_remaining - 1);
find_kth_factor(I, N, K_remaining) ->
    find_kth_factor(I + 1, N, K_remaining).