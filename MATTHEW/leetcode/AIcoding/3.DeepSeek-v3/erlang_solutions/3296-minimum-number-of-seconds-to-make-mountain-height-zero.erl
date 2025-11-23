-module(solution).
-export([minimum_seconds/1]).

minimum_seconds(Mountain) ->
    N = length(Mountain),
    Left = lists:duplicate(N, 0),
    Right = lists:duplicate(N, 0),
    Left1 = fill_left(Mountain, Left, 1),
    Right1 = fill_right(Mountain, Right, N - 2),
    calculate_min(Mountain, Left1, Right1, 0, 0).

fill_left(Mountain, Left, I) when I >= length(Mountain) ->
    Left;
fill_left(Mountain, Left, I) ->
    Prev = lists:nth(I, Left),
    Curr = lists:nth(I - 1, Mountain),
    NewVal = max(Curr + 1, Prev),
    NewLeft = setnth(I + 1, Left, NewVal),
    fill_left(Mountain, NewLeft, I + 1).

fill_right(Mountain, Right, I) when I < 0 ->
    Right;
fill_right(Mountain, Right, I) ->
    Next = lists:nth(I + 2, Right),
    Curr = lists:nth(I + 1, Mountain),
    NewVal = max(Curr + 1, Next),
    NewRight = setnth(I + 1, Right, NewVal),
    fill_right(Mountain, NewRight, I - 1).

calculate_min(Mountain, Left, Right, I, Min) when I >= length(Mountain) ->
    Min;
calculate_min(Mountain, Left, Right, I, Min) ->
    M = lists:nth(I + 1, Mountain),
    L = lists:nth(I + 1, Left),
    R = lists:nth(I + 1, Right),
    Current = max(M, min(L, R)),
    NewMin = max(Min, Current - M),
    calculate_min(Mountain, Left, Right, I + 1, NewMin).

setnth(1, [_|Rest], New) -> [New|Rest];
setnth(I, [E|Rest], New) -> [E|setnth(I-1, Rest, New)].