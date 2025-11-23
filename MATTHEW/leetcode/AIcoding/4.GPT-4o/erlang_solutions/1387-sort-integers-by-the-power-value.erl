-module(solution).
-export([getKth|getKth/3]).

getKth(Low, High, K) ->
    PowerValues = [power_value(X) || X <- lists:seq(Low, High)],
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A < B end, PowerValues),
    {Num, _} = lists:nth(K, Sorted),
    Num.

power_value(N) when N > 1 ->
    power_value(N, 0);
power_value(1) ->
    {1, 0}.

power_value(1, Count) -> 
    {1, Count};
power_value(N, Count) ->
    power_value(next(N), Count + 1).

next(N) when N rem 2 == 0 -> 
    N div 2;
next(N) -> 
    3 * N + 1.