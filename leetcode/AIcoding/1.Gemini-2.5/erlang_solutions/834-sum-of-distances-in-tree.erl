-module(solution).
-export([sum_of_distances_in_tree/2]).

build_adj(N, Edges) ->
    Adj0 = array:new([{fixed, true}, {size, N}, {default, []}]),
    lists:foldl(fun([U, V], AccAdj) ->
                    AccAdj1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
                    array:set(V, [U | array:get(V, AccAdj1)], AccAdj1)
                end, Adj0, Edges).

dfs1(U, Parent, Adj, CountAcc, DistSumAcc) ->
    CountAcc1 = array:set(U, 1, CountAcc),
    DistSumAcc1 = array:set(U, 0, DistSumAcc),

    Neighbors = array:get(U, Adj),
    lists:foldl(fun(V, {CurrentCount, CurrentDistSum}) ->
                    if V == Parent ->
                        {CurrentCount, CurrentDistSum};
                    true ->
                        {UpdatedCount, UpdatedDistSum} = dfs1(V, U, Adj, CurrentCount, CurrentDistSum),

                        Count_U = array:get(U, UpdatedCount),
                        Count_V = array:get(V, UpdatedCount),
                        DistSum_U = array:get(U, UpdatedDistSum),
                        DistSum_V = array:get(V, UpdatedDistSum),

                        NewCountAcc = array:set(U, Count_U + Count_V, UpdatedCount),
                        NewDistSumAcc = array:set(U, DistSum_U + DistSum_V + Count_V, UpdatedDistSum),
                        {NewCountAcc, NewDistSumAcc}
                    end
                end, {CountAcc1, DistSumAcc1}, Neighbors).

dfs2(U, Parent, N, Adj, Count, AnsAcc) ->
    Neighbors = array:get(U, Adj),
    lists:foldl(fun(V, CurrentAns) ->
                    if V == Parent ->
                        CurrentAns;
                    true ->
                        Ans_U = array:get(U, CurrentAns),
                        Count_V = array:get(V, Count),

                        Ans_V = Ans_U - Count_V + (N - Count_V),

                        CurrentAns1 = array:set(V, Ans_V, CurrentAns),
                        dfs2(V, U, N, Adj, Count, CurrentAns1)
                    end
                end, AnsAcc, Neighbors).

sum_of_distances_in_tree(N, Edges) ->
    Adj = build_adj(N, Edges),

    Count0 = array:new([{fixed, true}, {size, N}, {default, 0}]),
    DistSum0 = array:new([{fixed, true}, {size, N}, {default, 0}]),

    {Count1, DistSum1} = dfs1(0, -1, Adj, Count0, DistSum0),

    Ans0 = array:new([{fixed, true}, {size, N}, {default, 0}]),
    Ans1 = array:set(0, array:get(0, DistSum1), Ans0),

    Ans2 = dfs2(0, -1, N, Adj, Count1, Ans1),

    array:to_list(Ans2).