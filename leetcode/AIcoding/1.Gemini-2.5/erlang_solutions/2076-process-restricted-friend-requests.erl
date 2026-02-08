-module(solution).
-export([canBeFriends/3]).

init_dsu(N) ->
    ParentMap = maps:from_list([{I, I} || I <- lists:seq(0, N-1)]),
    RankMap = maps:from_list([{I, 0} || I <- lists:seq(0, N-1)]),
    {ParentMap, RankMap}.

find(ParentMap, I) ->
    case maps:get(I, ParentMap) of
        I -> {ParentMap, I};
        P ->
            {NewParentMap0, Root} = find(ParentMap, P),
            {maps:put(I, Root, NewParentMap0), Root}
    end.

union(ParentMap, RankMap, I, J) ->
    {ParentMap1, RootI} = find(ParentMap, I),
    {ParentMap2, RootJ} = find(ParentMap1, J),

    if RootI == RootJ ->
        {ParentMap2, RankMap};
    else
        RankI = maps:get(RootI, RankMap),
        RankJ = maps:get(RootJ, RankMap),

        if RankI < RankJ ->
            NewParentMap = maps:put(RootI, RootJ, ParentMap2),
            {NewParentMap, RankMap};
        else if RankJ < RankI ->
            NewParentMap = maps:put(RootJ, RootI, ParentMap2),
            {NewParentMap, RankMap};
        else
            NewParentMap = maps:put(RootJ, RootI, ParentMap2),
            NewRankMap = maps:put(RootI, RankI + 1, RankMap),
            {NewParentMap, NewRankMap}
        end
    end.

canBeFriends(N, Restrictions, Requests) ->
    InitialDSU = init_dsu(N),
    process_requests(Requests, Restrictions, InitialDSU, []).

process_requests([], _Restrictions, _DSU, Acc) ->
    lists:reverse(Acc);
process_requests([[P1, P2] | RestRequests], Restrictions, {ParentMap, RankMap} = CurrentDSU, Acc) ->
    {ParentMap_after_P1, RootP1} = find(ParentMap, P1),
    {ParentMap_after_P2, RootP2} = find(ParentMap_after_P1, P2),

    CanConnect = check_restrictions(Restrictions, RootP1, RootP2, ParentMap_after_P2),

    if CanConnect ->
        {NewParentMap, NewRankMap} = union(ParentMap_after_P2, RankMap, P1, P2),
        process_requests(RestRequests, Restrictions, {NewParentMap, NewRankMap}, [true | Acc]);
    else
        process_requests(RestRequests, Restrictions, CurrentDSU, [false | Acc])
    end.

check_restrictions([], _RootP1, _RootP2, _ParentMap) ->
    true;
check_restrictions([[R1, R2] | RestRestrictions], RootP1, RootP2, ParentMap) ->
    {ParentMap_after_R1, RootR1} = find(ParentMap, R1),
    {ParentMap_after_R2, RootR2} = find(ParentMap_after_R1, R2),

    IsViolated = (RootP1 == RootR1 andalso RootP2 == RootR2) orelse
                 (RootP1 == RootR2 andalso RootP2 == RootR1);

    if IsViolated ->
        false;
    else
        check_restrictions(RestRestrictions, RootP1, RootP2, ParentMap_after_R2)
    end.