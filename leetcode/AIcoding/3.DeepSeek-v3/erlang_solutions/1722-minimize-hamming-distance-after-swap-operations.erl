-module(solution).
-export([minimum_hamming_distance/3]).

minimum_hamming_distance(Source, Target, AllowedSwaps) ->
    N = length(Source),
    Parent = lists:seq(0, N - 1),
    UnionFind = union_find(AllowedSwaps, Parent),
    Groups = group_indices(UnionFind),
    maps:fold(fun(_, Indices, Acc) ->
        SourceGroup = [lists:nth(I + 1, Source) || I <- Indices],
        TargetGroup = [lists:nth(I + 1, Target) || I <- Indices],
        Acc + count_mismatches(SourceGroup, TargetGroup)
    end, 0, Groups).

union_find([], Parent) -> Parent;
union_find([[A, B] | Rest], Parent) ->
    RootA = find(A, Parent),
    RootB = find(B, Parent),
    NewParent = if
        RootA =/= RootB -> setelement(RootB + 1, Parent, RootA);
        true -> Parent
    end,
    union_find(Rest, NewParent).

find(X, Parent) ->
    P = element(X + 1, Parent),
    if
        P =:= X -> X;
        true -> find(P, Parent)
    end.

group_indices(Parent) ->
    lists:foldl(fun(I, Acc) ->
        Root = find(I, Parent),
        maps:update_with(Root, fun(Indices) -> [I | Indices] end, [I], Acc)
    end, #{}, lists:seq(0, length(Parent) - 1)).

count_mismatches(Source, Target) ->
    SourceCount = count_elements(Source, #{}),
    TargetCount = count_elements(Target, #{}),
    maps:fold(fun(Key, Val, Acc) ->
        TargetVal = maps:get(Key, TargetCount, 0),
        Acc + max(0, Val - TargetVal)
    end, 0, SourceCount).

count_elements([], Map) -> Map;
count_elements([H | T], Map) ->
    count_elements(T, maps:update_with(H, fun(V) -> V + 1 end, 1, Map)).