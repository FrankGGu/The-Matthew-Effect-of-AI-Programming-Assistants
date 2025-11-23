-module(solution).
-export([longest_nice_substring/1]).

longest_nice_substring(Str) ->
    longest_nice_substring(Str, 0, string:length(Str), 0).

longest_nice_substring(Str, Start, End, MaxLen) when Start < End ->
    SubStr = string:substr(Str, Start + 1, End - Start),
    {Upper, Lower} = lists:foldl(fun(Char, {U, L}) ->
        if
            Char >= $A, Char =< $Z -> {U + 1, L};
            Char >= $a, Char =< $z -> {U, L + 1};
            true -> {U, L}
        end
    end, {0, 0}, string:to_list(SubStr)),
    case Upper > 0, Lower > 0 of
        true -> longest_nice_substring(Str, Start + 1, End, max(MaxLen, End - Start));
        false -> longest_nice_substring(Str, Start, End - 1, MaxLen)
    end;
longest_nice_substring(_, _, _, MaxLen) ->
    MaxLen.