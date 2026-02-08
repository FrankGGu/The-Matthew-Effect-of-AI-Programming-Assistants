-module(solution).
-export([min_coins_to_add/2]).

min_coins_to_add(C, T) ->
    Total = lists:sum(C),
    Max = lists:max(C),
    Target = Total + Max,
    Target - T.