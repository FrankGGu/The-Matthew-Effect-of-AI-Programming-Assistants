-module(solution).
-export([find_kth_character/2]).

find_kth_character(S, K) ->
    N = length(S),
    K1 = (K rem N) + 1,
    string:at(S, K1).