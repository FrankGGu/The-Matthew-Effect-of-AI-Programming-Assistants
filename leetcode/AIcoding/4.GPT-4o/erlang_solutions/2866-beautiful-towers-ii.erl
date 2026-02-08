-module(beautiful_towers).
-export([max_beautiful_towers/1]).

max_beautiful_towers(N) ->
    max_beautiful_towers(N, 0, 0).

max_beautiful_towers(0, _, _) -> 
    0;
max_beautiful_towers(N, A, B) when N > 0 ->
    C = max(A + 1, B + 2),
    max(max_beautiful_towers(N - 1, C, A), max_beautiful_towers(N - 1, A, C)).