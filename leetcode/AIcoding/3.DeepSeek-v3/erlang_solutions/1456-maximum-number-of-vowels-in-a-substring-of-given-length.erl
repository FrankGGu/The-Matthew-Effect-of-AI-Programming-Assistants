-spec max_vowels(S :: unicode:unicode_binary(), K :: integer()) -> integer().
max_vowels(S, K) ->
    Vowels = sets:from_list("aeiou"),
    SList = unicode:characters_to_list(S),
    Len = length(SList),
    Window = lists:sublist(SList, 1, K),
    InitialCount = lists:foldl(fun(Char, Acc) ->
        case sets:is_element(Char, Vowels) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Window),
    MaxCount = max_vowels(SList, K, 1, Len, InitialCount, InitialCount, Vowels),
    MaxCount.

max_vowels(SList, K, Left, Len, CurrentCount, MaxCount, Vowels) when Left + K - 1 < Len ->
    OutChar = lists:nth(Left, SList),
    InChar = lists:nth(Left + K, SList),
    NewCurrentCount = case sets:is_element(OutChar, Vowels) of
        true -> CurrentCount - 1;
        false -> CurrentCount
    end,
    NewCurrentCount2 = case sets:is_element(InChar, Vowels) of
        true -> NewCurrentCount + 1;
        false -> NewCurrentCount
    end,
    NewMaxCount = max(NewCurrentCount2, MaxCount),
    max_vowels(SList, K, Left + 1, Len, NewCurrentCount2, NewMaxCount, Vowels);
max_vowels(_SList, _K, _Left, _Len, _CurrentCount, MaxCount, _Vowels) ->
    MaxCount.