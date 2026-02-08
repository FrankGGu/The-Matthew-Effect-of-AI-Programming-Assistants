-module(solution).
-export([countPaths/2]).

dfs1(Grid, R, C, CurrentXor, Moves, HalfMoves, Map) ->
    M = tuple_size(Grid),
    N = tuple_size(element(1, Grid)),

    Val = element(C + 1, element(R + 1, Grid)),
    NewXor = CurrentXor bxor Val,

    if
        Moves == HalfMoves ->
            dict:update_counter({R, C, NewXor}, 1, Map);
        Moves < HalfMoves ->
            Map1 = if R + 1 < M -> dfs1(Grid, R + 1, C, NewXor, Moves + 1, HalfMoves, Map); true -> Map end,
            Map2 = if C + 1 < N -> dfs1(Grid, R, C + 1, NewXor, Moves + 1, HalfMoves, Map1); true -> Map1 end,
            Map2;
        true ->
            Map
    end.

dfs2(Grid, R, C, CurrentXor, Moves, HalfMoves, K, Map1, AccCount) ->
    M = tuple_size(Grid),
    N = tuple_size(element(1, Grid)),

    Val = element(C + 1, element(R + 1, Grid)),
    NewXor = CurrentXor bxor Val,

    TotalMoves = M + N - 2,
    RemainingMoves = TotalMoves - HalfMoves,

    if
        Moves == RemainingMoves ->
            TargetXorFromStart = K bxor NewXor bxor Val,
            case dict:find({R, C, TargetXorFromStart}, Map1) of
                {ok, Count} -> AccCount + Count;
                error -> AccCount
            end;
        Moves < RemainingMoves ->
            Count1 = if R - 1 >= 0 -> dfs2(Grid, R - 1, C, NewXor, Moves + 1, HalfMoves, K, Map1, AccCount); true -> AccCount end,
            Count2 = if C - 1 >= 0 -> dfs2(Grid, R, C - 1, NewXor, Moves + 1, HalfMoves, K, Map1, Count1); true -> Count1 end,
            Count2;
        true ->
            AccCount
    end.

countPaths(GridListList, K) ->
    Grid = list_to_tuple([list_to_tuple(Row) || Row <- GridListList]),
    M = tuple_size(Grid),
    N = tuple_size(element(1, Grid)),

    TotalMoves = M + N - 2,
    HalfMoves = TotalMoves div 2,

    Map1 = dict:new(),
    FinalMap1 = dfs1(Grid, 0, 0, 0, 0, HalfMoves, Map1),

    dfs2(Grid, M - 1, N - 1, 0, 0, HalfMoves, K, FinalMap1, 0).