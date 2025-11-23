-module(to_lower_case).
-export([to_lower/1]).

to_lower(Str) ->
    lists:map(fun(C) -> 
        if 
            C >= $A, C =< $Z -> C + 32;
            true -> C
        end
    end, Str).