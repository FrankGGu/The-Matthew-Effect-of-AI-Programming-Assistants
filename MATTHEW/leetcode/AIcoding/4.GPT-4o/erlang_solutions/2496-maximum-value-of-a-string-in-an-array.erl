-module(solution).
-export([maximum_value/1]).

maximum_value(Strings) ->
    lists:max(lists:map(fun(S) -> 
        case string:to_integer(S) of 
            {ok, Int} -> Int; 
            _ -> string:length(S) 
        end 
    end, Strings)).