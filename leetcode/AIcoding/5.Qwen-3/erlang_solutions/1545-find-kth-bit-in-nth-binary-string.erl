-module(solution).
-export([find_kth_bit/2]).

find_kth_bit(N, K) ->
    find_kth_bit(N, K, 1, 1).

find_kth_bit(N, K, Level, Pos) when Level == N ->
    if
        Pos == K -> 1;
        true -> 0
    end;
find_kth_bit(N, K, Level, Pos) ->
    NextLevel = Level + 1,
    NextPos = Pos * 2,
    case find_kth_bit(N, K, NextLevel, NextPos) of
        1 -> 1;
        0 ->
            if
                K == NextPos -> 0;
                true -> 1
            end
    end.