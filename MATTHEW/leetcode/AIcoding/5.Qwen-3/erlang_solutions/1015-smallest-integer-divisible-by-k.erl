-module(small_divisible_by_k).
-export([smallest_repunit/1]).

smallest_repunit(K) ->
    smallest_repunit(K, 0, 1).

smallest_repunit(K, _, N) when N rem K == 0 ->
    N;
smallest_repunit(K, Seen, N) ->
    R = N rem K,
    case lists:member(R, Seen) of
        true -> -1;
        false -> smallest_repunit(K, [R | Seen], N * 10 + 1)
    end.