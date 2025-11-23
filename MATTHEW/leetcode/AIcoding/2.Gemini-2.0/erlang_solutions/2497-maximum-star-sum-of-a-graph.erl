-module(maximum_star_sum).
-export([max_star_sum/2]).

max_star_sum(Vals, Edges) ->
    N = length(Vals),
    Adj = lists:foldl(fun({U, V}, Acc) ->
                              Acc#{U => lists:append(lists:get(U, Acc, []), [V]),
                                  V => lists:append(lists:get(V, Acc, [], []), [U])}
                      end, #{}, Edges),

    lists:max([max_star_sum_helper(I, Vals, Adj) || I <- lists:seq(1, N)]).

max_star_sum_helper(Node, Vals, Adj) ->
    Neighbors = lists:get(Node, Adj, []),

    NeighborVals = [lists:nth(N - 1, Vals) || N <- Neighbors],
    SortedNeighborVals = lists:sort(NeighborVals),

    K = min(length(SortedNeighborVals), 3),

    Sum = lists:sum(lists:sublist(lists:reverse(SortedNeighborVals), 1, K)),

    lists:nth(Node, Vals) + max(0, Sum).