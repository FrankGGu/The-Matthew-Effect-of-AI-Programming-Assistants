-module(bulb_switcher).
-export([num_bulbs/1]).

num_bulbs(N) ->
    trunc(math:sqrt(N)).