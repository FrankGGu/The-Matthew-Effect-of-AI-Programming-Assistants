-module(solution).
-export([number_of_good_paths/1]).

number_of_good_paths(Vals) ->
    number_of_good_paths(Vals, []).

number_of_good_paths(Vals, Edges) ->
    N = length(Vals),
    if N == 0 -> 0;
       true ->
            Parents = lists:seq(0, N-1),
            Count = lists:duplicate(N, 1),
            Sorted = lists:sort(fun(I, J) -> 
                                    {Vi, _} = lists:nth(I+1, Vals),
                                    {Vj, _} = lists:nth(J+1, Vals),
                                    if Vi == Vj -> I =< J;
                                       true -> Vi < Vj
                                    end
                                end, lists:seq(0, N-1)),
            Adj = build_adj(N, Edges),
            Res = process_nodes(Sorted, Vals, Adj, Parents, Count, 0),
            Res
    end.

build_adj(N, Edges) ->
    Adj = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
                    U1 = U + 1,
                    V1 = V + 1,
                    AccU = lists:nth(U1, Acc),
                    AccV = lists:nth(V1, Acc),
                    NewAcc = lists:sublist(Acc, U1-1) ++ [[V | AccU]] ++ lists:nthtail(U1, Acc),
                    NewAcc1 = lists:sublist(NewAcc, V1-1) ++ [[U | AccV]] ++ lists:nthtail(V1, NewAcc),
                    NewAcc1
                end, Adj, Edges).

process_nodes([], _, _, _, _, Res) -> Res;
process_nodes([Node | Rest], Vals, Adj, Parents, Count, Res) ->
    {Val, _} = lists:nth(Node+1, Vals),
    Neighbors = lists:nth(Node+1, Adj),
    Filtered = lists:filter(fun(N) -> 
                                {NV, _} = lists:nth(N+1, Vals),
                                NV =< Val
                            end, Neighbors),
    Roots = lists:map(fun(N) -> find_root(N, Parents) end, Filtered),
    Grouped = group_roots(Roots),
    NewRes = lists:foldl(fun({_, C}, Acc) -> Acc + C * (C + 1) div 2 end, Res, Grouped),
    NewParents = lists:foldl(fun(Root, Acc) ->
                                RootParent = lists:nth(Root+1, Acc),
                                if RootParent == Node -> Acc;
                                   true ->
                                        NewAcc = lists:sublist(Acc, Root+1) ++ [Node] ++ lists:nthtail(Root+2, Acc),
                                        NewAcc
                                end
                            end, Parents, Roots),
    NewCount = lists:foldl(fun(Root, Acc) ->
                                RootCount = lists:nth(Root+1, Acc),
                                NodeCount = lists:nth(Node+1, Acc),
                                NewNodeCount = RootCount + NodeCount,
                                NewAcc = lists:sublist(Acc, Node+1) ++ [NewNodeCount] ++ lists:nthtail(Node+2, Acc),
                                NewAcc
                            end, Count, Roots),
    process_nodes(Rest, Vals, Adj, NewParents, NewCount, NewRes).

find_root(Node, Parents) ->
    Parent = lists:nth(Node+1, Parents),
    if Parent == Node -> Node;
       true -> find_root(Parent, Parents)
    end.

group_roots(Roots) ->
    lists:foldl(fun(R, Acc) ->
                    case lists:keyfind(R, 1, Acc) of
                        false -> [{R, 1} | Acc];
                        {R, C} -> lists:keyreplace(R, 1, Acc, {R, C+1})
                    end
                end, [], Roots).