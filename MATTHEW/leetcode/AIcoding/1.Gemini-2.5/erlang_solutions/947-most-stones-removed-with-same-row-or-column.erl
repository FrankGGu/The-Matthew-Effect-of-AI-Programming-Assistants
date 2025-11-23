-module(solution).
-export([removeStones/1]).

init_dsu(N) ->
    lists:foldl(fun(I, Map) -> maps:put(I, I, Map) end, #{}, lists:seq(0, N - 1)).

find(I, ParentMap) ->
    case maps:get(I, ParentMap) of
        I -> {I, ParentMap};
        ParentI ->
            {Root, NewParentMap} = find(ParentI, ParentMap),
            {Root, maps:put(I, Root, NewParentMap)}
    end.

union(I, J, ParentMap) ->
    {RootI, ParentMap1} = find(I, ParentMap),
    {RootJ, ParentMap2} = find(J, ParentMap1),
    if
        RootI =/= RootJ ->
            maps:put(RootJ, RootI, ParentMap2);
        true ->
            ParentMap2
    end.

removeStones(Stones) ->
    N = length(Stones),
    if N =< 1 -> 0; true -> ok end,

    IndexedStones = lists:zip(lists:seq(0, N - 1), Stones),

    InitialParentMap = init_dsu(N),

    FinalParentMap = lists:foldl(
        fun({I, StoneI}, CurrentParentMap) ->
            lists:foldl(
                fun({J, StoneJ}, InnerParentMap) ->
                    if
                        I < J,
                        (element(1, StoneI) == element(1, StoneJ) orelse
                         element(2, StoneI) == element(2, StoneJ)) ->
                            union(I, J, InnerParentMap);
                        true ->
                            InnerParentMap
                    end
                end,
                CurrentParentMap,
                IndexedStones
            )
        end,
        InitialParentMap,
        IndexedStones
    ),

    AllRoots = lists:map(
        fun(I) ->
            {Root, _} = find(I, FinalParentMap),
            Root
        end,
        lists:seq(0, N - 1)
    ),
    NumComponents = sets:size(sets:from_list(AllRoots)),

    N - NumComponents.