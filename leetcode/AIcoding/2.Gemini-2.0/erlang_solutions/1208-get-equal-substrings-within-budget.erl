-module(get_equal_substrings_within_budget).
-export([equal_substring/3]).

equal_substring(S, T, MaxCost) ->
    equal_substring(S, T, MaxCost, 0, 0, 0).

equal_substring(S, T, MaxCost, Start, End, MaxLen) ->
    LenS = length(S),
    LenT = length(T),
    if
        End >= LenS orelse End >= LenT ->
            MaxLen;
        true ->
            Cost = abs(list_to_integer(string:substr(S, End + 1, 1)) - list_to_integer(string:substr(T, End + 1, 1))),
            if
                Cost > MaxCost ->
                    equal_substring(S, T, MaxCost, Start + 1, Start + 1, MaxLen);
                true ->
                    equal_substring(S, T, MaxCost - Cost, Start, End + 1, max(MaxLen, End - Start + 1))
            end
    end.