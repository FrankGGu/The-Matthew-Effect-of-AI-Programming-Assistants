-module(solution).
-export([countPairs/3]).

find(I, Parents) ->
    ParentI = array:get(I, Parents),
    if
        ParentI == I -> I;
        true ->
            Root = find(ParentI, Parents),
            array:set(I, Root, Parents)
    end.

union(I, J, Parents) ->
    RootI = find(I, Parents),
    RootJ = find(J, Parents),
    if
        RootI /= RootJ -> array:set(RootI, RootJ, Parents);
        true -> Parents
    end.

countPairs(N, Edges, Props) ->
    InitialParents = array:from_list(lists:seq(0, N-1)),

    FinalParents = lists:foldl(
        fun([U, V], AccParents) ->
            union(U, V, AccParents)
        end,
        InitialParents,
        Edges
    ),

    RootPropertyCounts = maps:new(),
    RootPropertyCounts = lists:foldl(
        fun(I, AccMap) ->
            Root = find(I, FinalParents),
            Prop = lists:nth(I + 1, Props),

            maps:update_with(Root,
                             fun(PropMap) ->
                                 maps:update_with(Prop,
                                                  fun(Count) -> Count + 1 end,
                                                  1,
                                                  PropMap)
                             end,
                             maps:put(Prop, 1, maps:new()),
                             AccMap)
        end,
        RootPropertyCounts,
        lists:seq(0, N-1)
    ),

    TotalPairs = maps:fold(
        fun(_Root, PropMap, AccPairs) ->
            ComponentPairs = maps:fold(
                fun(_Prop, Count, AccPropPairs) ->
                    AccPropPairs + (Count * (Count - 1) div 2)
                end,
                0,
                PropMap
            ),
            AccPairs + ComponentPairs
        end,
        0,
        RootPropertyCounts
    ),
    TotalPairs.