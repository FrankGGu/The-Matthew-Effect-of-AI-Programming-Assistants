-module(solution).
-export([get_smooth_descent_periods/1]).

get_smooth_descent_periods(Prices) ->
    smooth_descent_periods(Prices, 0, 0).

smooth_descent_periods([], Acc, Total) -> Total + Acc;
smooth_descent_periods([_], Acc, Total) -> Total + Acc + 1;
smooth_descent_periods([H1, H2 | T], Acc, Total) when H2 < H1 -> 
    smooth_descent_periods([H2 | T], Acc + 1, Total);
smooth_descent_periods([H1, H2 | T], Acc, Total) -> 
    smooth_descent_periods([H2 | T], 0, Total + Acc + 1).