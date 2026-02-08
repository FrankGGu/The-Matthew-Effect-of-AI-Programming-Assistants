-module(solution).
-export([count_odd_numbers/2]).

count_odd_numbers(Low, High) ->
    (High + 1) div 2 - Low div 2.