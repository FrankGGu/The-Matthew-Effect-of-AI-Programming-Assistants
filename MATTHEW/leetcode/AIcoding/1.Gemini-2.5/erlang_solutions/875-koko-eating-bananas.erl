-module(solution).
-export([min_eating_speed/2]).

can_eat(Piles, H, K) ->
    TotalHours = lists:foldl(fun(Pile, Acc) ->
                                 HoursForPile = (Pile + K - 1) div K,
                                 Acc + HoursForPile
                             end, 0, Piles),
    TotalHours =< H.

min_eating_speed(Piles, H) ->
    Low = 1,
    High = lists:max(Piles),

    binary_search(Piles, H, Low, High, High).

binary_search(_Piles, _H, Low, High, Ans) when Low > High ->
    Ans;
binary_search(Piles, H, Low, High, CurrentBestAns) ->
    Mid = Low + (High - Low) div 2,
    case can_eat(Piles, H, Mid) of
        true ->
            binary_search(Piles, H, Low, Mid - 1, Mid);
        false ->
            binary_search(Piles, H, Mid + 1, High, CurrentBestAns)
    end.