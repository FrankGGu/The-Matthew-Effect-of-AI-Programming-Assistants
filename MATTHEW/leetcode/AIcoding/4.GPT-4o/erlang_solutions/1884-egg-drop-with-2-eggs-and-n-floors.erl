-module(solution).
-export([twoEggDrop/1]).

twoEggDrop(N) when N =< 0 -> 0;
twoEggDrop(N) -> twoEggDrop_helper(N, 1).

twoEggDrop_helper(N, K) ->
    case K * (K + 1) div 2 >= N of
        true -> K;
        false -> twoEggDrop_helper(N, K + 1)
    end.