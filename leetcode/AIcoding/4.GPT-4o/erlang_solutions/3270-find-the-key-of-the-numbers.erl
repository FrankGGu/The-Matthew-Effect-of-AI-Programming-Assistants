-module(solution).
-export([find_key/2]).

find_key(Numbers, Key) ->
    lists:filter(fun(X) -> X rem Key =:= 0 end, Numbers).