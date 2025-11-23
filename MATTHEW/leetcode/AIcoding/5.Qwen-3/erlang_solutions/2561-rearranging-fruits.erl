-module(rearranging_fruits).
-export([rearrange_fruits/1]).

rearrange_fruits(Fruits) ->
    lists:sort(Fruits).