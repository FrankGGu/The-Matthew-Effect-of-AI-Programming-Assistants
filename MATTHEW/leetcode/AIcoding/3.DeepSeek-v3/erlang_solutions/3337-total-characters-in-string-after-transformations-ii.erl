-module(solution).
-export([total_characters/2]).

total_characters(Original, Changes) ->
    Dict = lists:foldl(fun([A, B], Acc) ->
                           maps:put(A, B, Acc)
                       end, #{}, Changes),
    lists:foldl(fun(C, Sum) ->
                   case maps:get(C, Dict, undefined) of
                       undefined -> Sum + 1;
                       B -> Sum + length(B)
                   end
                end, 0, Original).