-module(anagrams).
-export([find_anagrams/2]).

find_anagrams(S, P) ->
    LenP = length(P),
    LenS = length(S),
    if
        LenP > LenS -> [];
        true ->
            PCount = count_chars(P),
            SCount = count_chars(substring(S, 1, LenP)),
            Result = [],
            find_anagrams(S, P, PCount, SCount, 1, Result)
    end.

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) -> dict:update_counter(Char, 1, Acc) end, dict:new(), Str).

find_anagrams(_, _, _, _, _, Result) when Result == [] -> Result;
find_anagrams(S, P, PCount, SCount, Index, Result) ->
    case compare_dicts(PCount, SCount) of
        true ->
            NewResult = [Index - 1 | Result],
            NextIndex = Index + 1,
            NextWindow = substring(S, NextIndex, len(P)),
            NewSCount = update_window(SCount, substring(S, Index, 1), substring(S, NextIndex + LenP - 1, 1)),
            find_anagrams(S, P, PCount, NewSCount, NextIndex, NewResult);
        false ->
            NextIndex = Index + 1,
            NextWindow = substring(S, NextIndex, len(P)),
            NewSCount = update_window(SCount, substring(S, Index, 1), substring(S, NextIndex + LenP - 1, 1)),
            find_anagrams(S, P, PCount, NewSCount, NextIndex, Result)
    end.

compare_dicts(Dict1, Dict2) ->
    dict:is_equal(Dict1, Dict2).

update_window(Count, OutChar, InChar) ->
    Count1 = dict:update_counter(OutChar, -1, Count),
    dict:update_counter(InChar, 1, Count1).

substring(Str, Start, Length) ->
    string:substr(Str, Start, Length).