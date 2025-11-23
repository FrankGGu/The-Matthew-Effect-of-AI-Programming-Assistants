-module(solution).
-export([isAnagram/2]).

isAnagram(S, T) ->
    if
        length(S) =/= length(T) ->
            false;
        true ->
            MapS = count_chars(S),
            MapT = count_chars(T),
            MapS =:= MapT
    end.

count_chars(String) ->
    lists:foldl(fun(Char, Map) ->
                    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Map)
                end, #{}, String).