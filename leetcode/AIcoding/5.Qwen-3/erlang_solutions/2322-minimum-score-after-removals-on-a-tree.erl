-module(minimum_score_after_removals_on_a_tree).
-export([minimumScore/1]).

minimumScore(Edges) ->
    N = length(Edges) + 1,
    Graph = build_graph(Edges, N),
    Total = N,
    {_, _, Min} = dfs(0, -1, Graph, Total),
    Min.

build_graph([], _) -> [];
build_graph([[A,B]|T], N) ->
    G = build_graph(T, N),
    AVal = lists:keyfind(A, 1, G),
    BVal = lists:keyfind(B, 1, G),
    case AVal of
        false -> [{A, [B]} | G];
        _ -> lists:keystore(A, 1, G, {A, lists:append(element(2, AVal), [B])})
    end,
    case BVal of
        false -> [{B, [A]} | G];
        _ -> lists:keystore(B, 1, G, {B, lists:append(element(2, BVal), [A])})
    end.

dfs(Node, Parent, Graph, Total) ->
    Sums = lists:map(fun(Child) ->
                        if Child /= Parent ->
                            {Subtree, _, _} = dfs(Child, Node, Graph, Total);
                            Subtree
                        end
                    end, element(2, lists:keyfind(Node, 1, Graph))),
    Sum = lists:sum(Sums),
    Max = lists:max(Sums),
    Min = lists:min(Sums),
    Current = Sum + 1,
    Other = Total - Current,
    {Current, Max, min(Min, abs(Current - Max), abs(Other - Max))}.