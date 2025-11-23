-module(solution).
-export([divisibility_array/1]).

divisibility_array(Str) ->
    N = length(Str),
    lists:seq(1, N),
    lists:map(fun(I) -> 
        Num = list_to_integer(lists:sublist(Str, I)),
        case Num rem 2 of
            0 -> 1;
            _ -> 0
        end
    end, lists:seq(1, N)).