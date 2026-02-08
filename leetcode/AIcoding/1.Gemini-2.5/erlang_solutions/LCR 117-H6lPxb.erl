-module(solution).
-export([numSimilarGroups/1]).

find_pc(I, Parent) ->
    case maps:get(I, Parent) of
        I -> {I, Parent};
        P -> 
            {Root, NewParent} = find_pc(P, Parent),
            {Root, maps:put(I, Root, NewParent)}
    end.

union(I, J, Parent, Rank) ->
    {RootI, Parent1} = find_pc(I, Parent),
    {RootJ, Parent2} = find_pc(J, Parent1),

    if RootI /= RootJ ->
        RankI = maps:get(RootI, Rank),
        RankJ = maps:get(RootJ, Rank),
        if RankI < RankJ ->
            {maps:put(RootI, RootJ, Parent2), Rank};
        RankI > RankJ ->
            {maps:put(RootJ, RootI, Parent2), Rank};
        true -> %% RankI == RankJ
            {maps:put(RootJ, RootI, Parent2), maps:put(RootI, RankI + 1, Rank)}
        end;
    true -> %% Already in the same set
        {Parent2, Rank}
    end.

is_similar(S1, S2) ->
    is_similar_check(S1, S2, [], 0).

is_similar_check([], [], Diffs, _) ->
    case length(Diffs) of
        0 -> true;
        2 ->
            [{C1_1, C2_1}, {C1_2, C2_2}] = Diffs,
            C1_1 == C2_2 andalso C1_2 == C2_1;
        _ -> false
    end;
is_similar_check([C1|T1], [C2|T2], Diffs, DiffCount) when C1 == C2 ->
    is_similar_check(T1, T2, Diffs, DiffCount);
is_similar_check([C1|T1], [C2|T2], Diffs, DiffCount) ->
    case DiffCount of
        2 -> false;
        _ -> is_similar_check(T1, T2, [{C1, C2}|Diffs], DiffCount + 1)
    end;
is_similar_check(_, _, _, _) ->
    false.

connect_similar_strings(Strs, NumStrings, Parent, Rank) ->
    StrsArray = array:from_list(Strs),
    connect_loop(0, NumStrings, StrsArray, Parent, Rank).

connect_loop(I, NumStrings, StrsArray, Parent, Rank) when I < NumStrings ->
    S1 = array:get(I, StrsArray),
    {ParentN, RankN} = connect_inner_loop(I + 1, NumStrings, S1, I, StrsArray, Parent, Rank),
    connect_loop(I + 1, NumStrings, StrsArray, ParentN, RankN);
connect_loop(_, _, _, Parent, Rank) ->
    {Parent, Rank}.

connect_inner_loop(J, NumStrings, S1, I, StrsArray, Parent, Rank) when J < NumStrings ->
    S2 = array:get(J, StrsArray),
    {NewParent, NewRank} = 
        case is_similar(S1, S2) of
            true -> union(I, J, Parent, Rank);
            false -> {Parent, Rank}
        end,
    connect_inner_loop(J + 1, NumStrings, S1, I, StrsArray, NewParent, NewRank);
connect_inner_loop(_, _, _, _, _, Parent, Rank) ->
    {Parent, Rank}.

count_groups(Indices, Parent) ->
    FinalParent = lists:foldl(fun(I, AccParent) ->
        {_, NewAccParent} = find_pc(I, AccParent),
        NewAccParent
    end, Parent, Indices),

    RootSet = sets:new(),
    lists:foldl(fun(I, AccSet) ->
        sets:add_element(maps:get(I, FinalParent), AccSet)
    end, RootSet, Indices),
    sets:size(RootSet).

numSimilarGroups(Strs) ->
    NumStrings = length(Strs),

    Indices = lists:seq(0, NumStrings - 1),
    Parent0 = maps:from_list([{I, I} || I <- Indices]),
    Rank0 = maps:from_list([{I, 0} || I <- Indices]),

    {ParentF, _RankF} = connect_similar_strings(Strs, NumStrings, Parent0, Rank0),

    count_groups(Indices, ParentF).