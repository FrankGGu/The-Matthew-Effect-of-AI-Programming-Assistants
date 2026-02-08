-module(solution).
-export([equal_substrings/3]).

equal_substrings(S, T, maxCost) ->
    N = length(S),
    lists:foldl(fun({C, D}, {L, R}) -> 
        {L + (if C =:= D -> 1; true -> 0 end), 
         R + (if C =:= D -> 0; true -> abs(C - D) end)}
    end, {0, 0}, lists:zip(lists:map(fun (X) -> string:to_integer(X) end, string:to_list(S)), 
                            lists:map(fun (X) -> string:to_integer(X) end, string:to_list(T)))).