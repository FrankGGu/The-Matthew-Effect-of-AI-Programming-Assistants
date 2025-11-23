-module(moving_stones_until_consecutive_ii).
-export([numMovesStonesII/1]).

numMovesStonesII(Stones) ->
    [A, B, C | _] = lists:sort(Stones),
    if
        C - A == 2 -> 0;
        C - B == 1 andalso B - A == 1 -> 0;
        true ->
            Min = min(B - A - 1, C - B - 1),
            Max = (C - A - 2) - (B - A - 1) + (C - B - 1),
            case Min of
                0 -> 2;
                _ -> Min + 1
            end
    end.