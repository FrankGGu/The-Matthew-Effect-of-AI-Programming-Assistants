-spec count_substrings(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
count_substrings(S, T) ->
    SList = binary_to_list(S),
    TList = binary_to_list(T),
    LenT = length(TList),
    LenS = length(SList),
    if
        LenT > LenS -> 0;
        true ->
            Target = lists:sort(TList),
            count_substrings(SList, Target, LenT, LenS, 0)
    end.

count_substrings(_, _, LenT, LenS, Count) when LenT > LenS -> Count;
count_substrings(SList, Target, LenT, LenS, Count) ->
    Sub = lists:sublist(SList, LenT),
    SortedSub = lists:sort(Sub),
    NewCount = case SortedSub == Target of
        true -> Count + 1;
        false -> Count
    end,
    count_substrings(tl(SList), Target, LenT, LenS - 1, NewCount).