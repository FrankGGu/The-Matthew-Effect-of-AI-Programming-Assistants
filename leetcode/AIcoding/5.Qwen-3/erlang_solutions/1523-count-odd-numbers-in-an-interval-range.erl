-module(solution).
-export([odd_numbers/2]).

odd_numbers(low, high) ->
    Count = (high - low + 1) div 2,
    case (low rem 2 == 0 andalso high rem 2 == 0) of
        true -> Count;
        false -> Count + 1
    end.