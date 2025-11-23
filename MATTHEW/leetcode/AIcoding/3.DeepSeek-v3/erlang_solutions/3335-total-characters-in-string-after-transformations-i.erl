-module(solution).
-export([total_characters/2]).

total_characters(S, Changes) ->
    Dict = lists:foldl(fun([A, B], Acc) ->
                           maps:put(A, B, Acc)
                       end, #{}, Changes),
    lists:foldl(fun(Char, Sum) ->
                   case maps:get(Char, Dict, undefined) of
                       undefined -> Sum + 1;
                       NewChar -> Sum + length(NewChar)
                   end
                end, 0, S).