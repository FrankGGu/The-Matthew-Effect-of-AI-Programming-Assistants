-module(solution).
-export([divisibility_array/2]).

divisibility_array(S, k) ->
    Length = string:len(S),
    lists:map(fun(Index) -> 
        Num = list_to_integer(string:substr(S, 1, Index)),
        if 
            Num rem k =:= 0 -> 1;
            true -> 0
        end 
    end, lists:seq(1, Length)).