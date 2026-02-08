-module(solution).
-export([are_connected/2]).

make_set(N) ->
    Parents = gb_array:new(N + 1, fun(I) -> I end),
    Ranks = gb_array:new(N + 1, 0),
    {Parents, Ranks}.

find({Parents, Ranks}, I) ->
    ParentI = gb_array:get(I, Parents),
    if ParentI == I ->
        {I, {Parents, Ranks}};
    true ->
        {Root, {NewParents, NewRanks}} = find({Parents, Ranks}, ParentI),
        NewParents2 = gb_array:set(I, Root, NewParents),
        {Root, {NewParents2, NewRanks}}
    end.

union({Parents, Ranks}, I, J) ->
    {RootI, DSUState1} = find({Parents, Ranks}, I),
    {RootJ, DSUState2} = find(DSUState1, J),
    {Parents1, Ranks1} = DSUState2,

    if RootI /= RootJ ->
        RankI = gb_array:get(RootI, Ranks1),
        RankJ = gb_array:get(RootJ, Ranks1),
        if RankI < RankJ ->
            NewParents = gb_array:set(RootI, RootJ, Parents1),
            {true, {NewParents, Ranks1}};
        RankJ < RankI ->
            NewParents = gb_array:set(RootJ, RootI, Parents1),
            {true, {NewParents, Ranks1}};
        true ->
            NewParents = gb_array:set(RootJ, RootI, Parents1),
            NewRanks = gb_array:set(RootI, RankI + 1, Ranks1),
            {true, {NewParents, NewRanks}}
        end;
    true ->
        {false, {Parents1, Ranks1}}
    end.

are_connected(N, Threshold) ->
    DSUState0 = make_set(N),

    DSUStateFinal = lists:foldl(
        fun(I, CurrentDSUState) ->
            lists:foldl(
                fun(K, InnerDSUState) ->
                    J = K * I,
                    if J =< N ->
                        {_, NewInnerDSUState} = union(InnerDSUState, I, J),
                        NewInnerDSUState;
                    true ->
                        InnerDSUState
                    end
                end,
                CurrentDSUState,
                lists:seq(2, N div I)
            )
        end,
        DSUState0,
        lists:seq(Threshold + 1, N)
    ),

    {Root1, _} = find(DSUStateFinal, 1),

    lists:map(
        fun(I) ->
            {RootI, _} = find(DSUStateFinal, I),
            RootI == Root1
        end,
        lists:seq(1, N)
    ).