-module(solution).
-export([min_swaps_couples/1]).

min_swaps_couples(RowList) ->
    Row = array:from_list(RowList),
    Len = array:size(Row),
    N = Len div 2,

    Parents0 = maps:from_list([{I, I} || I <- lists:seq(0, N-1)]),

    union_find_solve(Row, 0, N, Parents0, N).

union_find_solve(Row, Index, N, Parents, NumComponents) when Index < 2*N ->
    P1 = array:get(Index, Row),
    P2 = array:get(Index + 1, Row),

    C1 = P1 div 2,
    C2 = P2 div 2,

    {RootC1, Parents1} = find(C1, Parents),
    {RootC2, Parents2} = find(C2, Parents1),

    if
        RootC1 == RootC2 ->
            union_find_solve(Row, Index + 2, N, Parents2, NumComponents);
        true ->
            NewParents = maps:put(RootC1, RootC2, Parents2),
            union_find_solve(Row, Index + 2, N, NewParents, NumComponents - 1)
    end;
union_find_solve(_Row, _Index, _N, _Parents, NumComponents) ->
    N - NumComponents.

find(I, Parents) ->
    ParentI = maps:get(I, Parents),
    if
        ParentI == I ->
            {I, Parents};
        true ->
            {Root, NewParents} = find(ParentI, Parents),
            {Root, maps:put(I, Root, NewParents)}
    end.