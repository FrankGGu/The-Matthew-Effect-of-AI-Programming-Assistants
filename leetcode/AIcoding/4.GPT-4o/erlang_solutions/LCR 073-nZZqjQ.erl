-module(solution).
-export([min_eating_speed/3]).

min_eating_speed(Piles, H, L) ->
    Max = lists:max(Piles),
    min_eating_speed_helper(Piles, H, 1, Max).

min_eating_speed_helper(Piles, H, Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    if
        can_finish(Piles, Mid, H) ->
            min_eating_speed_helper(Piles, H, Low, Mid);
        true ->
            min_eating_speed_helper(Piles, H, Mid + 1, High)
    end;
min_eating_speed_helper(_, _, Low, Low) ->
    Low.

can_finish(Piles, Speed, H) ->
    TotalHours = lists:foldl(fun(Pile, Acc) ->
        Acc + ceil(Pile / Speed)
    end, 0, Piles),
    TotalHours =< H.