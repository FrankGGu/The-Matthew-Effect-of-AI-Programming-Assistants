-module(solution).
-export([solve/3]).

make_set(N) ->
    Parent = array:from_list(lists:seq(0, N-1)),
    Rank = array:from_list(lists:duplicate(N, 1)),
    {Parent, Rank}.

find(Parent, I) ->
    RootI = array:get(I, Parent),
    if
        RootI == I -> {I, Parent};
        true ->
            {NewRoot, NewParent} = find(Parent, RootI),
            {NewRoot, array:set(I, NewRoot, NewParent)}
    end.

union(Parent, Rank, I, J) ->
    {RootI, Parent1} = find(Parent, I),
    {RootJ, Parent2} = find(Parent1, J),

    if
        RootI == RootJ ->
            {Parent2, Rank};
        true ->
            RankI = array:get(RootI, Rank),
            RankJ = array:get(RootJ, Rank),
            if
                RankI < RankJ ->
                    NewParent = array:set(RootI, RootJ, Parent2),
                    {NewParent, Rank};
                RankI > RankJ ->
                    NewParent = array:set(RootJ, RootI, Parent2),
                    {NewParent, Rank};
                true ->
                    NewParent = array:set(RootJ, RootI, Parent2),
                    NewRank = array:set(RootI, RankI + 1, Rank),
                    {NewParent, NewRank}
            end
    end.

solve(N, Edges, Queries) ->
    {InitialParent, InitialRank} = make_set(N),

    {FinalParent, _FinalRank} = lists:foldl(
        fun([U, V], {AccParent, AccRank}) ->
            union(AccParent, AccRank, U, V)
        end,
        {InitialParent, InitialRank},
        Edges
    ),

    lists:map(
        fun([U, V]) ->
            {RootU, _} = find(FinalParent, U),
            {RootV, _} = find(FinalParent, V),
            RootU == RootV
        end,
        Queries
    ).