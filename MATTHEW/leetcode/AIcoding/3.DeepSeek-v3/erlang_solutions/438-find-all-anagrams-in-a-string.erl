-spec find_anagrams(S :: unicode:unicode_binary(), P :: unicode:unicode_binary()) -> [integer()].
find_anagrams(S, P) ->
    SStr = unicode:characters_to_list(S),
    PStr = unicode:characters_to_list(P),
    LenS = length(SStr),
    LenP = length(PStr),
    if
        LenP > LenS -> [];
        true ->
            PCount = lists:foldl(fun(C, Acc) -> 
                                    maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                                  end, #{}, PStr),
            SCount = lists:foldl(fun(C, Acc) -> 
                                    maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                                  end, #{}, lists:sublist(SStr, LenP)),
            Res = check(0, LenS - LenP, SStr, PCount, SCount, LenP, []),
            Res
    end.

check(Index, MaxIndex, SStr, PCount, SCount, LenP, Acc) when Index =< MaxIndex ->
    case maps:to_list(PCount) == maps:to_list(SCount) of
        true -> 
            NewAcc = [Index | Acc],
            next_check(Index, MaxIndex, SStr, PCount, SCount, LenP, NewAcc);
        false -> 
            next_check(Index, MaxIndex, SStr, PCount, SCount, LenP, Acc)
    end;
check(_, _, _, _, _, _, Acc) ->
    lists:reverse(Acc).

next_check(Index, MaxIndex, SStr, PCount, SCount, LenP, Acc) ->
    LeftChar = lists:nth(Index + 1, SStr),
    NewSCount = case maps:get(LeftChar, SCount, 0) of
                    1 -> maps:remove(LeftChar, SCount);
                    V -> maps:put(LeftChar, V - 1, SCount)
                end,
    RightChar = lists:nth(Index + LenP + 1, SStr),
    FinalSCount = maps:update_with(RightChar, fun(V) -> V + 1 end, 1, NewSCount),
    check(Index + 1, MaxIndex, SStr, PCount, FinalSCount, LenP, Acc).