-module(magnetic_force_between_two_balls).
-export([maximize_min_force/2]).

maximize_min_force(Balls, K) ->
    BallsSorted = lists:sort(Balls),
    low = 0,
    high = lists:last(BallsSorted) - lists:nth(1, BallsSorted),
    binary_search(BallsSorted, K, low, high).

binary_search(_, _, Low, High) when Low >= High ->
    Low;
binary_search(Balls, K, Low, High) ->
    Mid = (Low + High) div 2,
    case can_place(Balls, K, Mid) of
        true ->
            binary_search(Balls, K, Mid + 1, High);
        false ->
            binary_search(Balls, K, Low, Mid)
    end.

can_place(_, 1, _) ->
    true;
can_place(Balls, K, MinDist) ->
    Count = 1,
    LastPos = lists:nth(1, Balls),
    can_place(Balls, K, MinDist, Count, LastPos).

can_place([], _, _, Count, _) ->
    Count >= 2;
can_place([Ball | Rest], K, MinDist, Count, LastPos) ->
    if
        Ball - LastPos >= MinDist ->
            NewCount = Count + 1,
            if
                NewCount >= K ->
                    true;
                true ->
                    can_place(Rest, K, MinDist, NewCount, Ball)
            end;
        true ->
            can_place(Rest, K, MinDist, Count, LastPos)
    end.