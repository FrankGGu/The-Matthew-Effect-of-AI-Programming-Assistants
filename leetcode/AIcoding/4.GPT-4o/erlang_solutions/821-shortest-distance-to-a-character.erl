-module(solution).
-export([shortest_to_char/2]).

shortest_to_char(S, C) ->
    Length = string:length(S),
    Distances = lists:map(fun(I) -> 
        if 
            string:at(S, I) =:= C -> 0;
            true -> Length
        end 
    end, lists:seq(1, Length)),
    lists:foldl(fun(I, Acc) -> 
        case Acc of 
            [] -> [I];
            [Prev | _] -> 
                [min(I, Prev + 1) | Acc]
        end 
    end, [], lists:reverse(Distances)
    ).