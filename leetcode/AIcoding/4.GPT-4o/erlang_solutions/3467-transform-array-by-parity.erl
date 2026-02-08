-module(solution).
-export([transform_array/1]).

transform_array(Array) ->
    lists:flatmap(fun(X) -> [X rem 2, X div 2] end, Array).