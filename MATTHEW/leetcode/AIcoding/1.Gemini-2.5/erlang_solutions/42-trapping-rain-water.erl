-module(solution).
-export([trap/1]).

trap(HeightList) ->
    N = length(HeightList),
    if
        N < 3 -> 0;
        true ->
            HeightArray = array:from_list(HeightList),
            trap_two_pointers(HeightArray, 0, N - 1, 0, 0, 0)
    end.

trap_two_pointers(HeightArray, Left, Right, MaxLeft, MaxRight, TotalWater) when Left =< Right ->
    H_Left = array:get(Left, HeightArray),
    H_Right = array:get(Right, HeightArray),

    if
        H_Left < H_Right ->
            NewMaxLeft = max(MaxLeft, H_Left),
            Water = max(0, NewMaxLeft - H_Left),
            trap_two_pointers(HeightArray, Left + 1, Right, NewMaxLeft, MaxRight, TotalWater + Water);
        true ->
            NewMaxRight = max(MaxRight, H_Right),
            Water = max(0, NewMaxRight - H_Right),
            trap_two_pointers(HeightArray, Left, Right - 1, MaxLeft, NewMaxRight, TotalWater + Water)
    end;
trap_two_pointers(_HeightArray, _Left, _Right, _MaxLeft, _MaxRight, TotalWater) ->
    TotalWater.