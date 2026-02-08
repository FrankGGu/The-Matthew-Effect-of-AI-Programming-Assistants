-module(solution).
-export([minEatingSpeed/2]).

minEatingSpeed(Piles, H) ->
    MaxPile = lists:max(Piles),
    Low = 1,
    High = MaxPile,
    binary_search(Low, High, H, Piles, MaxPile).

binary_search(Low, High, H, Piles, CurrentMinK) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case can_finish(Mid, Piles, H) of
        true ->
            binary_search(Low, Mid - 1, H, Piles, Mid);
        false ->
            binary_search(Mid + 1, High, H, Piles, CurrentMinK)
    end;
binary_search(_Low, _High, _H, _Piles, CurrentMinK) ->
    CurrentMinK.

can_finish(K, Piles, H) ->
    HoursNeeded = lists:foldl(fun(Pile, Acc) -> Acc + (Pile + K - 1) div K end, 0, Piles),
    HoursNeeded =< H.