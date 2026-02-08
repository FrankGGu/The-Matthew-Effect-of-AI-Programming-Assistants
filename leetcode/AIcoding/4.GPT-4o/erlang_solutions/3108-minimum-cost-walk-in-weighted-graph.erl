-module(solution).
-export([min_cost_walk/3]).

min_cost_walk(Start, End, Edges) ->
    Graph = build_graph(Edges),
    dijsktra(Graph, Start, End, []).

build_graph(Edges) ->
    lists:foldl(fun({A, B, C}, Acc) ->
        Map1 = maps:update_with(A, fun(L) -> [B | L] end, [B], Acc),
        Map2 = maps:update_with(B, fun(L) -> [A | L] end, [A], Map1),
        maps:put(A, maps:get(A, Map2), Map2)
    end, maps:new(), Edges).

dijsktra(Graph, Start, End, Visited) ->
    case maps:is_key(Start, Graph) of
        false -> infinity;
        true ->
            Paths = lists:foldl(fun(Next, Acc) ->
                case lists:keyfind(Next, 1, Acc) of
                    false -> [{Next, get_cost(Graph, Start, Next) + get_cost(Graph, Next, End)} | Acc];
                    _ -> Acc
                end
            end, [], maps:get(Start, Graph)),
            case lists:foldl(fun({Node, Cost}, Acc) ->
                if
                    Node == End -> min(Cost, Acc);
                    true -> Acc
                end
            end, infinity, Paths) of
                infinity -> infinity;
                MinCost -> MinCost + get_cost(Graph, Start, End)
            end
    end.

get_cost(Graph, A, B) ->
    case lists:keyfind(B, 1, maps:get(A, Graph)) of
        {B, Cost} -> Cost;
        false -> infinity
    end.

min(A, B) when A < B -> A;
min(_, B) -> B.