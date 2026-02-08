-spec first_almost_equal_substring(S :: unicode:unicode_binary(), T :: unicode:unicode_binary(), MaxCost :: integer()) -> unicode:unicode_binary().
first_almost_equal_substring(S, T, MaxCost) ->
    SList = binary_to_list(S),
    TList = binary_to_list(T),
    Len = min(length(SList), length(TList)),
    find_substring(SList, TList, MaxCost, Len, 0, 0, 0, 0, 0).

find_substring(_, _, _, Len, Start, End, _, _, _) when End >= Len ->
    binary:part(unicode:characters_to_binary(""), {Start, End - Start});
find_substring(S, T, MaxCost, Len, Start, End, Cost, MinStart, MinLen) ->
    NewCost = Cost + abs(lists:nth(End + 1, S) - lists:nth(End + 1, T)),
    if
        NewCost =< MaxCost ->
            NewEnd = End + 1,
            if
                NewEnd - Start > MinLen ->
                    find_substring(S, T, MaxCost, Len, Start, NewEnd, NewCost, Start, NewEnd - Start);
                true ->
                    find_substring(S, T, MaxCost, Len, Start, NewEnd, NewCost, MinStart, MinLen)
            end;
        true ->
            NewStart = Start + 1,
            NewEnd = End + 1,
            if
                NewStart < NewEnd ->
                    NewCost2 = Cost - abs(lists:nth(Start + 1, S) - lists:nth(Start + 1, T)),
                    find_substring(S, T, MaxCost, Len, NewStart, End, NewCost2, MinStart, MinLen);
                true ->
                    find_substring(S, T, MaxCost, Len, NewStart, NewEnd, 0, MinStart, MinLen)
            end
    end.