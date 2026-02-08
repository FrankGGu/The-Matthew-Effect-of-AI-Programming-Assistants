-module(solution).
-export([largest_element/1]).

largest_element(Array) ->
    lists:max(Array).