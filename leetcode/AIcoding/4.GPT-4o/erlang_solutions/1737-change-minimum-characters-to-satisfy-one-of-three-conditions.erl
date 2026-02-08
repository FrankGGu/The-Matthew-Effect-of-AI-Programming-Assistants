-module(solution).
-export([min_character_change/2]).

min_character_change(Str1, Str2) ->
    Length = length(Str1),
    MaxChar = 26,
    Counts1 = counts(Str1, MaxChar),
    Counts2 = counts(Str2, MaxChar),
    MinChanges = min(min_changes(Counts1, Counts2, Length, true),
                     min_changes(Counts1, Counts2, Length, false)),
    MinChanges.

counts(Str, MaxChar) ->
    lists:foldl(fun(C, Acc) -> Acc + 1 bsl (C - $a) end, 
                 lists:duplicate(MaxChar, 0), 
                 Str).

min_changes(Counts1, Counts2, Length, Condition) ->
    lists:foldl(fun(I, Acc) ->
                    Change = Length - (Counts1(I) + Counts2(I)),
                    if
                        Condition -> min(Acc, Change);
                        true -> min(Acc, Counts1(I) + Counts2(I))
                    end
                end, Length, lists:seq(1, 26)).