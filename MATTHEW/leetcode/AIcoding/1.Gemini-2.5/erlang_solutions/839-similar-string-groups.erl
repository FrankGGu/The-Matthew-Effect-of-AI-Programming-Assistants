-module(solution).
-export([numSimilarGroups/1]).

find(I, Parents) ->
    Parent = maps:get(I, Parents),
    if Parent == I ->
        {I, Parents};
    true ->
        {Root, UpdatedParents} = find(Parent, Parents),
        {Root, maps:put(I, Root, UpdatedParents)}
    end.

union(I, J, Parents) ->
    {RootI, Parents1} = find(I, Parents),
    {RootJ, Parents2} = find(J, Parents1),
    if RootI == RootJ ->
        Parents2;
    true ->
        maps:put(RootI, RootJ, Parents2)
    end.

is_similar(S1, S2) ->
    L1 = length(S1),
    L2 = length(S2),
    if L1 =/= L2 ->
        false;
    true ->
        Diff = lists:zip(S1, S2),
        {DiffCount, DiffChars} = lists:foldl(
            fun({C1, C2}, {Count, Chars}) ->
                if C1 =/= C2 -> {Count+1, [{C1, C2}|Chars]};
                   true -> {Count, Chars}
                end
            end,
            {0, []},
            Diff
        ),
        case DiffCount of
            0 -> true;
            2 ->
                [{C1a, C2a}, {C1b, C2b}] = DiffChars,
                C1a == C2b andalso C1b == C2a;
            _ -> false
        end
    end.

numSimilarGroups(Strs) ->
    N = length(Strs),
    InitialParents = maps:from_list([{I, I} || I <- lists:seq(0, N-1)]),

    %% Iterate through all pairs of strings and union their sets if similar
    FinalParents = lists:foldl(
        fun(I, CurrentParents) ->
            lists:foldl(
                fun(J, InnerParents) ->
                    S_I = lists:nth(I+1, Strs), %% lists:nth is 1-based
                    S_J = lists:nth(J+1, Strs),
                    if is_similar(S_I, S_J) ->
                        union(I, J, InnerParents);
                    true ->
                        InnerParents
                    end
                end,
                CurrentParents,
                lists:seq(I+1, N-1)
            )
        end,
        InitialParents,
        lists:seq(0, N-2)
    ),

    %% Count distinct roots
    Roots = sets:new(),
    {FinalRootsSet, _} = lists:foldl(
        fun(I, {CurrentRoots, CurrentParents}) ->
            {Root, UpdatedParents} = find(I, CurrentParents),
            {sets:add_element(Root, CurrentRoots), UpdatedParents}
        end,
        {Roots, FinalParents},
        lists:seq(0, N-1)
    ),
    sets:size(FinalRootsSet).