-module(solution).
-export([find_coins/3]).

build_adj(N, Edges) ->
    InitialAdj = array:new({size, N}),
    lists:foldl(
        fun([U, V], AccAdj) ->
            AccAdj1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
            array:set(V, [U | array:get(V, AccAdj)], AccAdj1)
        end,
        InitialAdj,
        Edges
    ).

merge_and_trim(List1, List2) ->
    Combined = List1 ++ List2,
    Sorted = lists:sort(Combined),
    Len = length(Sorted),
    if
        Len =< 5 -> Sorted;
        true ->
            [lists:nth(1, Sorted), lists:nth(2, Sorted),
             lists:nth(Len-2, Sorted), lists:nth(Len-1, Sorted), lists:nth(Len, Sorted)]
    end.

dfs(U, Parent, Adj, ValuesArray, ResultArray) ->
    CurrentValue = array:get(U, ValuesArray),
    InitialSubtreeValues = [CurrentValue],
    InitialSubtreeCount = 1,

    Children = lists:filter(fun(V) -> V /= Parent end, array:get(U, Adj)),

    %% Recursively call DFS for children and accumulate results
    {FinalSubtreeCount, FinalSubtreeValues, IntermediateResultArray} =
        lists:foldl(
            fun(V, {AccCount, AccValues, AccResultArray}) ->
                {ChildCount, ChildValues, NewAccResultArray} = dfs(V, U, Adj, ValuesArray, AccResultArray),
                {AccCount + ChildCount, merge_and_trim(AccValues, ChildValues), NewAccResultArray}
            end,
            {InitialSubtreeCount, InitialSubtreeValues, ResultArray},
            Children
        ),

    %% Calculate coins for the current node U
    CoinsU =
        if
            FinalSubtreeCount < 3 -> 1;
            true ->
                %% FinalSubtreeValues is already sorted by merge_and_trim
                SortedValues = FinalSubtreeValues,
                Len = length(SortedValues),

                %% Get the 2 smallest and 3 largest values
                S1 = lists:nth(1, SortedValues),
                S2 = lists:nth(2, SortedValues),
                Sk = lists:nth(Len, SortedValues),
                Sk_1 = lists:nth(Len-1, SortedValues),
                Sk_2 = lists:nth(Len-2, SortedValues),

                %% Calculate products
                P1 = Sk * Sk_1 * Sk_2,
                P2 = S1 * S2 * Sk,

                %% The number of coins is max(0, P1, P2)
                max(0, max(P1, P2))
        end,

    %% Update the result array for node U
    UpdatedResultArray = array:set(U, CoinsU, IntermediateResultArray),
    {FinalSubtreeCount, FinalSubtreeValues, UpdatedResultArray}.

find_coins(N, Edges, ValuesList) ->
    Adj = build_adj(N, Edges),
    ValuesArray = array:from_list(ValuesList),
    InitialResultArray = array:new({size, N}),

    %% Start DFS from node 0 (assuming it's the root, parent -1)
    {_, _, FinalResultArray} = dfs(0, -1, Adj, ValuesArray, InitialResultArray),

    %% Convert the final result array to a list
    array:to_list(FinalResultArray).