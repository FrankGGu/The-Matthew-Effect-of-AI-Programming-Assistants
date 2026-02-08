-module(solution).
-export([shortest_uncommon_substring/1]).

shortest_uncommon_substring(StrList) ->
    MinLen = lists:foldl(fun(S, Acc) -> min(Acc, string:length(S)) end, infinity, StrList),
    lists:foldl(fun(L, Acc) -> find_shortest_uncommon(L, StrList, Acc) end, "", lists:seq(1, MinLen)).

find_shortest_uncommon(S, StrList, Acc) ->
    SubStrs = [string:substring(S, Start, Length) || Start <- lists:seq(1, string:length(S)), Length <- lists:seq(1, string:length(S) - Start + 1)],
    lists:foldl(fun(Sub, Acc) ->
        if 
            not lists:member(Sub, StrList) -> 
                if string:length(Sub) < string:length(Acc) orelse Acc == "" -> Sub; 
                true -> Acc 
                end;
            true -> Acc
        end
    end, Acc, SubStrs).