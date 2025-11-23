-module(solution).
-export([max_coins/1]).

-spec max_coins(Piles :: [integer()]) -> integer().
max_coins(Piles) ->
    SortedPiles = lists:sort(Piles),
    N = length(SortedPiles),
    NumPicks = N div 3,
    ReversedPiles = lists:reverse(SortedPiles),
    sum_my_coins(ReversedPiles, NumPicks, 0).

sum_my_coins(_, 0, Acc) ->
    Acc;
sum_my_coins([_AlicePile, MyPile | Rest], NumPicks, Acc) ->
    % _AlicePile is the largest pile in the current group of three (taken by Alice).
    % MyPile is the second largest pile in the current group of three (taken by me).
    % The head of Rest (tl(Rest)) is the smallest pile in the current group of three (taken by Bob).
    % So, for the next iteration, we skip Bob's pile by taking tl(Rest).
    sum_my_coins(tl(Rest), NumPicks - 1, Acc + MyPile).