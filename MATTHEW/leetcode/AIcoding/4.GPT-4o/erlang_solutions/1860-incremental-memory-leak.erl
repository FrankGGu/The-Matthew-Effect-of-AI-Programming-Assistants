-module(solution).
-export([memLeak/3]).

memLeak(A, B, C) ->
    loop(A, B, C, 1).

loop(A, B, C, Day) ->
    case {A, B} of
        {0, 0} -> {Day - 1, 0, 0};
        {A1, B1} when A1 < Day -> loop(B1, C, 0, Day + 1);
        {A1, B1} when B1 < Day -> loop(A1, C, 0, Day + 1);
        _ -> loop(A - Day, B - Day, C, Day + 1)
    end.