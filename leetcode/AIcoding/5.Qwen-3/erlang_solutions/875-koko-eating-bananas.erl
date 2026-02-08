-module(koko_eating_bananas).
-export([min_eating_speed/2]).

min_eating_speed(Piles, H) ->
    Low = 1,
    High = lists:max(Piles),
    binary_search(Piles, H, Low, High).

binary_search(_, _, Low, High) when Low == High ->
    Low;
binary_search(Piles, H, Low, High) ->
    Mid = (Low + High) div 2,
    Time = time_to_eat(Piles, Mid),
    if
        Time =< H ->
            binary_search(Piles, H, Low, Mid);
        true ->
            binary_search(Piles, H, Mid + 1, High)
    end.

time_to_eat([], _) ->
    0;
time_to_eat([P | Piles], K) ->
    Time = ceil(P / K),
    Time + time_to_eat(Piles, K).

ceil(X) when X =< 0 ->
    0;
ceil(X) ->
    T = trunc(X),
    if
        X > T -> T + 1;
        true -> T
    end.