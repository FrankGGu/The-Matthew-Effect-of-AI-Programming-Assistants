-module(mice_and_cheese).
-export([mouseSim/3]).

mouseSim(Height, Width, Mice) ->
    mouseSim(Height, Width, Mice, 0, 0, 0).

mouseSim(_Height, _Width, [], _R, _C, Acc) ->
    Acc;
mouseSim(Height, Width, [Mouse | Rest], R, C, Acc) ->
    {DirR, DirC} = direction(Mouse),
    NewR = R + DirR,
    NewC = C + DirC,
    if
        NewR >= 0, NewR < Height, NewC >= 0, NewC < Width ->
            mouseSim(Height, Width, Rest, NewR, NewC, Acc + 1);
        true ->
            mouseSim(Height, Width, Rest, R, C, Acc)
    end.

direction('U') -> {-1, 0};
direction('D') -> {1, 0};
direction('L') -> {0, -1};
direction('R') -> {0, 1}.