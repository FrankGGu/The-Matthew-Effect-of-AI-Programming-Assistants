-module(solution).
-export([bulb_switch/1]).

bulb_switch(N) ->
    floor(math:sqrt(N)).