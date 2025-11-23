-spec find_anagrams(S :: unicode:unicode_binary(), P :: unicode:unicode_binary()) -> [integer()].
find_anagrams(S, P) ->
    SStr = unicode:characters_to_list(S),
    PStr = unicode:characters_to_list(P),
    LenP = length(PStr),
    LenS = length(SStr),
    if
        LenS < LenP -> [];
        true ->
            PCount = lists:foldl(fun(C, Acc) -> 
                                    maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                                 end, #{}, PStr),
            SCount = lists:foldl(fun(C, Acc) -> 
                                    maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                                 end, #{}, lists:sublist(SStr, LenP)),
            Res = check(0, LenS - LenP, SStr, PCount, SCount, LenP, []),
            lists:reverse(Res)
    end.

check(Index, MaxIndex, SStr, PCount, SCount, LenP, Acc) when Index =< MaxIndex ->
    case maps:keys(PCount) -- maps:keys(SCount) of
        [] ->
            case lists:all(fun(K) -> maps:get(K, PCount) =:= maps:get(K, SCount) end, maps:keys(PCount)) of
                true ->
                    NewAcc = [Index | Acc];
                false ->
                    NewAcc = Acc
            end;
        _ ->
            NewAcc = Acc
    end,
    if
        Index =:= MaxIndex ->
            NewAcc;
        true ->
            FirstChar = lists:nth(Index + 1, SStr),
            LastChar = lists:nth(Index + LenP + 1, SStr),
            NewSCount1 = case maps:get(FirstChar, SCount, 0) of
                            1 -> maps:remove(FirstChar, SCount);
                            V -> maps:put(FirstChar, V - 1, SCount)
                          end,
            NewSCount2 = maps:update_with(LastChar, fun(V) -> V + 1 end, 1, NewSCount1),
            check(Index + 1, MaxIndex, SStr, PCount, NewSCount2, LenP, NewAcc)
    end;
check(_, _, _, _, _, _, Acc) ->
    Acc.