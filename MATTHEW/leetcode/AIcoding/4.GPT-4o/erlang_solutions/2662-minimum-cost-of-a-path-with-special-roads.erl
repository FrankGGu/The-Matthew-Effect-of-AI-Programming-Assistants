-module(solution).
-export([min_cost/3]).

min_cost(N, roads, start) ->
    {ok, Graph} = build_graph(N, roads),
    D = lists:duplicate(N, infinity),
    D1 = lists:sublist(D, 0, start) ++ [0] ++ lists:sublist(D, start + 1, N - start - 1),
    min_cost_dp(Graph, D1, N).

build_graph(N, Roads) ->
    Graph = lists:foldl(fun({from, to, cost}, Acc) ->
        lists:foldl(fun(To) -> [{from, To, cost} | Acc] end, Acc, To)
    end, [], Roads),
    {ok, Graph}.

min_cost_dp(Graph, D, N) ->
    lists:foldl(fun(_, Acc) -> relax_edges(Graph, Acc, N) end, D, lists:seq(1, N)).

relax_edges(Graph, D, N) ->
    lists:foldl(fun({From, To, Cost}, Acc) ->
        if
            lists:nth(From, Acc) + Cost < lists:nth(To, Acc) -> 
                lists:replace(To, lists:nth(From, Acc) + Cost, Acc);
            true -> 
                Acc
        end
    end, D, Graph).

lists:replace(Index, NewValue, List) ->
    lists:sublist(List, 1, Index - 1) ++ [NewValue] ++ lists:sublist(List, Index + 1, length(List) - Index).