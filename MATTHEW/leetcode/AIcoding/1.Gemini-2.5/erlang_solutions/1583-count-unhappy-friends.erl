-spec count_unhappy_friends(N :: integer(), Preferences :: [[integer()]], Pairs :: [[integer()]]) -> integer().
count_unhappy_friends(N, Preferences, Pairs) ->
    RankMap = build_rank_map(N, Preferences),
    PartnerMap = build_partner_map(Pairs),
    count_unhappy(0, N, RankMap, PartnerMap, Preferences, 0).

build_rank_map(N, Preferences) ->
    lists:foldl(fun(I, Acc) ->
        PrefList = lists:nth(I + 1, Preferences),
        FriendRanks = maps:from_list(lists:zip(PrefList, lists:seq(0, length(PrefList) - 1))),
        maps:put(I, FriendRanks, Acc)
    end, #{}, lists:seq(0, N - 1)).

build_partner_map(Pairs) ->
    lists:foldl(fun([X, Y], Acc) ->
        maps:put(Y, X, maps:put(X, Y, Acc))
    end, #{}, Pairs).

count_unhappy(CurrentFriend, N, RankMap, PartnerMap, Preferences, UnhappyCount) when CurrentFriend < N ->
    Partner = maps:get(CurrentFriend, PartnerMap),
    CurrentFriendPrefs = lists:nth(CurrentFriend + 1, Preferences),

    PreferredOverPartner = lists:takewhile(fun(U) -> U =/= Partner end, CurrentFriendPrefs),

    IsUnhappy = check_if_unhappy(CurrentFriend, PreferredOverPartner, RankMap, PartnerMap),

    NewUnhappyCount = if IsUnhappy -> UnhappyCount + 1;
                         true -> UnhappyCount
                      end,
    count_unhappy(CurrentFriend + 1, N, RankMap, PartnerMap, Preferences, NewUnhappyCount);
count_unhappy(_CurrentFriend, _N, _RankMap, _PartnerMap, _Preferences, UnhappyCount) ->
    UnhappyCount.

check_if_unhappy(X, PreferredOverY, RankMap, PartnerMap) ->
    lists:any(fun(U) ->
        V = maps:get(U, PartnerMap),
        X_Rank_in_U_Prefs = maps:get(X, maps:get(U, RankMap)),
        V_Rank_in_U_Prefs = maps:get(V, maps:get(U, RankMap)),
        X_Rank_in_U_Prefs < V_Rank_in_U_Prefs
    end, PreferredOverY).