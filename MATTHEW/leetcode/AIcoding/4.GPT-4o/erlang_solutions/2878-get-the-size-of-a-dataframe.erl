-module(solution).
-export([get_size/1]).

get_size(DataFrame) ->
    length(DataFrame).