-module(solution).
-export([max_repeated_character_substring/1]).

max_repeated_character_substring(Str) ->
    MaxLen = length(Str),
    CharCounts = lists:foldl(fun (C, Acc) -> 
        case lists:keyfind(C, 1, Acc) of
            false -> [{C, 1} | Acc];
            {C, Count} -> [{C, Count + 1} | lists:keydelete(C, 1, Acc)]
        end
    end, [], string:to_list(Str)),
    lists:max(lists:map(fun {Char, Count} -> 
        Count + lists:max([Count || {OtherChar, OtherCount} <- CharCounts, OtherChar =/= Char]) 
    end, CharCounts)).