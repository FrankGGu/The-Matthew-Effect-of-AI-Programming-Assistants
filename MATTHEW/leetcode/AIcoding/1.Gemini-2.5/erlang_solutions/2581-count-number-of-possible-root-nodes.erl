-module(solution).
-export([countPossibleRootNodes/4]).

countPossibleRootNodes(N, Edges, Guesses, K) ->
    Adj = lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
            array:set(V, [U | array:get(V, Acc1)], Acc1)
        end,
        array:new(N, {default, []}),
        Edges
    ),

    GuessSet = gb_sets:from_list([ {U, V} || [U, V] <- Guesses ]),

    InitialCorrect = dfs_initial(0, -1, Adj, GuessSet),

    dfs_reroot(0, -1, InitialCorrect, Adj, GuessSet, K, 0).

dfs_initial(U, P, Adj, GuessSet) ->
    lists:foldl(
        fun(V, Acc) ->
            if
                V =:= P -> Acc;
                true ->
                    EdgeGuessCorrect = if gb_sets:is_member({U, V}, GuessSet) -> 1; true -> 0 end,
                    Acc + EdgeGuessCorrect + dfs_initial(V, U, Adj, GuessSet)
            end
        end,
        0,
        array:get(U, Adj)
    ).

dfs_reroot(U, P, CurrentCorrect, Adj, GuessSet, K, Acc) ->
    NewAcc = if CurrentCorrect >= K -> Acc + 1; true -> Acc end,

    lists:foldl(
        fun(V, CurrentAcc) ->
            if
                V =:= P -> CurrentAcc;
                true ->
                    NewCorrect = CurrentCorrect
                        - (if gb_sets:is_member({U, V}, GuessSet) -> 1; true -> 0 end)
                        + (if gb_sets:is_member({V, U}, GuessSet) -> 1; true -> 0 end),
                    dfs_reroot(V, U, NewCorrect, Adj, GuessSet, K, CurrentAcc)
            end
        end,
        NewAcc,
        array:get(U, Adj)
    ).