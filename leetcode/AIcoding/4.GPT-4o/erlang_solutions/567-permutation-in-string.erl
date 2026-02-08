-module(solution).
-export([check_inclusion/2]).

check_inclusion(S1, S2) ->
    {L1, L2} = {string:length(S1), string:length(S2)},
    if 
        L1 > L2 -> false;
        true -> 
            Count1 = count_chars(S1),
            Count2 = count_chars(string:sub(S2, 1, L1)),
            check(Count1, Count2) orelse check_substring(S2, L1, Count1, Count2)
    end.

count_chars(Str) ->
    lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, #{}, string:to_list(Str)).

check(CharCount1, CharCount2) ->
    maps:equals(CharCount1, CharCount2).

check_substring(S2, L1, Count1, Count2) ->
    lists:foldl(fun(Idx, Acc) -> 
        CharOut = string:substr(S2, Idx, 1),
        CharIn = string:substr(S2, Idx + L1, 1),
        Count2 = maps:update_with(CharOut, fun(X) -> X - 1 end, 0, Count2),
        Count2 = maps:update_with(CharIn, fun(X) -> X + 1 end, 1, Count2),
        Acc orelse check(Count1, Count2)
    end, false, lists:seq(1, string:length(S2) - L1)).