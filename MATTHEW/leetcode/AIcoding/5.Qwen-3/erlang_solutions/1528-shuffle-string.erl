-module(shuffle_string).
-export([shuffle_string/2]).

shuffle_string(S, Indices) ->
    lists:foldl(fun({Char, Index}, Acc) -> 
                    lists:put(Index, Char, Acc) 
                end, lists:duplicate(length(S), 0), lists:zip(S, Indices)).