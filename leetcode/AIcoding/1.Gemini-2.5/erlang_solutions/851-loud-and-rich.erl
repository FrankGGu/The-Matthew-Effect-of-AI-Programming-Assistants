-module(solution).
-export([loudAndRich/2]).

loudAndRich(Richer, Quiet) ->
    N = length(Quiet),

    QuietArray = array:from_list(Quiet),

    Adj = build_adj_list(N, Richer),

    InitialMemoMap = maps:from_list([{I, undefined} || I <- lists:seq(0, N-1)]),

    {FinalResultsListReversed, _FinalMemoMap} = lists:foldl(
        fun(I, {AccResults, CurrentMemoMap}) ->
            {ResultForI, NewMemoMap} = dfs(I, Adj, QuietArray, CurrentMemoMap),
            {[ResultForI | AccResults], NewMemoMap}
        end,
        {[], InitialMemoMap},
        lists:seq(0, N-1)
    ),

    lists:reverse(FinalResultsListReversed).

build_adj_list(N, Richer) ->
    Adj0 = array:from_list([[] || _ <- lists:seq(0, N-1)]),

    lists:foldl(
        fun([A, B], CurrentAdj) ->
            ParentsOfB = array:get(B, CurrentAdj),
            array:set(B, [A | ParentsOfB], CurrentAdj)
        end,
        Adj0,
        Richer
    ).

dfs(U, Adj, QuietArray, MemoMap) ->
    case maps:get(U, MemoMap) of
        undefined ->
            CurrentQuietestPerson = U,

            Parents = array:get(U, Adj),

            {FinalQuietestPerson, FinalMemoMap} = lists:foldl(
                fun(Parent, {AccQuietestPerson, AccMemoMap}) ->
                    {ParentResult, NewAccMemoMap} = dfs(Parent, Adj, QuietArray, AccMemoMap),

                    ParentResultValue = array:get(ParentResult, QuietArray),
                    AccQuietestValue = array:get(AccQuietestPerson, QuietArray),

                    if ParentResultValue < AccQuietestValue ->
                        {ParentResult, NewAccMemoMap};
                    true ->
                        {AccQuietestPerson, NewAccMemoMap}
                    end
                end,
                {CurrentQuietestPerson, MemoMap},
                Parents
            ),

            NewMemoMapWithResult = maps:put(U, FinalQuietestPerson, FinalMemoMap),
            {FinalQuietestPerson, NewMemoMapWithResult};

        Result ->
            {Result, MemoMap}
    end.