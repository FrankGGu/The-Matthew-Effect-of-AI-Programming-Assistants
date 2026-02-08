-module(solution).
-export([sum_of_distances_in_tree/2]).

sum_of_distances_in_tree(N, Edges) ->
    Adj = build_adjacency_list(N, Edges),
    Count = lists:duplicate(N, 1),
    Res = lists:duplicate(N, 0),
    {Count1, Res1} = post_order(0, -1, Adj, Count, Res),
    {_, Res2} = pre_order(0, -1, Adj, Count1, Res1),
    Res2.

build_adjacency_list(N, Edges) ->
    Adj = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
                    U1 = U + 1,
                    V1 = V + 1,
                    Acc1 = update_adj(U1, V1, Acc),
                    update_adj(V1, U1, Acc1)
                end, Adj, Edges).

update_adj(U, V, Adj) ->
    List = lists:nth(U, Adj),
    lists:sublist(Adj, U - 1) ++ [[V | List]] ++ lists:nthtail(U, Adj).

post_order(Node, Parent, Adj, Count, Res) ->
    Children = lists:nth(Node, Adj),
    {Count1, Res1} = lists:foldl(fun(Child, {CntAcc, ResAcc}) ->
                                    if Child =/= Parent ->
                                        {CntChild, ResChild} = post_order(Child, Node, Adj, CntAcc, ResAcc),
                                        CntNew = update_list(Node, lists:nth(Child, CntChild), CntChild),
                                        ResNew = update_list(Node, lists:nth(Child, ResChild) + lists:nth(Child, CntChild), ResChild),
                                        {CntNew, ResNew};
                                    true ->
                                        {CntAcc, ResAcc}
                                    end
                                 end, {Count, Res}, Children),
    {Count1, Res1}.

pre_order(Node, Parent, Adj, Count, Res) ->
    Children = lists:nth(Node, Adj),
    Res1 = lists:foldl(fun(Child, ResAcc) ->
                          if Child =/= Parent ->
                              ResChild = lists:nth(Node, ResAcc),
                              CountChild = lists:nth(Child, Count),
                              CountTotal = length(Count),
                              NewVal = ResChild - CountChild + (CountTotal - CountChild),
                              update_list(Child, NewVal, ResAcc);
                          true ->
                              ResAcc
                          end
                       end, Res, Children),
    {Count1, Res2} = lists:foldl(fun(Child, {CntAcc, ResAcc}) ->
                                    if Child =/= Parent ->
                                        pre_order(Child, Node, Adj, CntAcc, ResAcc);
                                    true ->
                                        {CntAcc, ResAcc}
                                    end
                                 end, {Count, Res1}, Children),
    {Count1, Res2}.

update_list(Index, Value, List) ->
    lists:sublist(List, Index - 1) ++ [Value] ++ lists:nthtail(Index, List).