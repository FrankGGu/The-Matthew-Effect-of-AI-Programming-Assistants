-module(solution).
-export([kth_stair/2]).

kth_stair(K, N) ->
    kth_stair(K, N, 1, 0, 1).

kth_stair(0, _, _, _, _) ->
    1;
kth_stair(K, N, Step, Prev, Current) when Step > K ->
    0;
kth_stair(K, N, Step, Prev, Current) ->
    Next = (Prev + Current) rem N,
    kth_stair(K, N, Step + 1, Current, Next).