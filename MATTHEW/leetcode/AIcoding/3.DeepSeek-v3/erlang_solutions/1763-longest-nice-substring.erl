-spec longest_nice_substring(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
longest_nice_substring(S) ->
    case S of
        <<>> -> <<>>;
        _ ->
            Chars = binary_to_list(S),
            UniqueChars = lists:usort(Chars),
            case check_nice(Chars, UniqueChars) of
                true -> S;
                false ->
                    MaxLen = 0,
                    MaxStr = <<>>,
                    {NewMaxLen, NewMaxStr} = find_longest_nice(S, 0, length(Chars), MaxLen, MaxStr),
                    NewMaxStr
            end
    end.

check_nice(Chars, UniqueChars) ->
    lists:all(fun(C) ->
        Lower = string:to_lower(C),
        Upper = string:to_upper(C),
        (Lower == Upper) orelse (lists:member(Lower, UniqueChars) andalso lists:member(Upper, UniqueChars))
    end, UniqueChars).

find_longest_nice(S, Start, End, MaxLen, MaxStr) when Start >= End ->
    {MaxLen, MaxStr};
find_longest_nice(S, Start, End, MaxLen, MaxStr) ->
    Sub = binary:part(S, Start, End - Start),
    Chars = binary_to_list(Sub),
    UniqueChars = lists:usort(Chars),
    case check_nice(Chars, UniqueChars) of
        true ->
            Len = End - Start,
            if
                Len > MaxLen -> {Len, Sub};
                true -> {MaxLen, MaxStr}
            end;
        false ->
            {Len1, Str1} = find_longest_nice(S, Start + 1, End, MaxLen, MaxStr),
            {Len2, Str2} = find_longest_nice(S, Start, End - 1, Len1, Str1),
            if
                Len2 > Len1 -> {Len2, Str2};
                true -> {Len1, Str1}
            end
    end.