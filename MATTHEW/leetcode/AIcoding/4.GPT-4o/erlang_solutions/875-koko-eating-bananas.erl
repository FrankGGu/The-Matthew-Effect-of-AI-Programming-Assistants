-module(solution).
-export([min_eating_speed/2]).

min_eating_speed(Piles, H) ->
    MinSpeed = 1,
    MaxSpeed = lists:max(Piles),
    min_eating_speed_helper(Piles, H, MinSpeed, MaxSpeed).

min_eating_speed_helper(Piles, H, Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    Time = calculate_time(Piles, Mid),
    case Time > H of
        true -> min_eating_speed_helper(Piles, H, Mid + 1, High);
        false -> min_eating_speed_helper(Piles, H, Low, Mid
    end;
min_eating_speed_helper(_, _, Low, Low) -> Low.

calculate_time(Piles, Speed) ->
    lists:sum(lists:map(fun(Pile) -> ceil(Pile / Speed) end, Piles)).