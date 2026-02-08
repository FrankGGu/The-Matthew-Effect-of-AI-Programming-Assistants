-module(solution).
-export([largest_odd_number/1]).

largest_odd_number(S) ->
    lists:foldl(fun(Char, Acc) ->
        case Acc of
            [] -> [Char];
            _ -> Acc ++ [Char]
        end
    end, [], lists:filter(fun(C) -> C >= $0 andalso C =< $9 end, list_to_string(S))).