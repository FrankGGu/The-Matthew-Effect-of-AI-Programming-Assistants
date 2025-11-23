-module(solution).
-export([calculate_delayed_arrival_time/2]).

calculate_delayed_arrival_time(ready_time, delay) ->
    Minutes = ready_time * 60 + delay,
    Hours = Minutes div 60,
    MinutesRemainder = Minutes rem 60,
    {Hours rem 24, MinutesRemainder}.