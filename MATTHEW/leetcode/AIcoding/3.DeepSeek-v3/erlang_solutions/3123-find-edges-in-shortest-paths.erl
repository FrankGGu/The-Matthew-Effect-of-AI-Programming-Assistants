-module(solution).
-export([find_answer/3]).

find_answer(N, Edges, Queries) ->
    Graph = build_graph(N, Edges),
    Dist = dijkstra(N, Graph),
    EdgesSet = sets:from_list(Edges),
    lists:map(fun({U, V}) -> 
        case sets:is_element({U, V}, EdgesSet) orelse sets:is_element({V, U}, EdgesSet) of
            true -> 
                case Dist[U] + 1 == Dist[V] orelse Dist[V] + 1 == Dist[U] of
                    true -> true;
                    false -> false
                end;
            false -> false
        end
    end, Queries).

build_graph(N, Edges) ->
    Graph = array:new([{size, N}, {default, []}]),
    lists:foldl(fun({U, V}, G) ->
        G1 = array:set(U, [V | array:get(U, G)], G),
        array:set(V, [U | array:get(V, G1)], G1)
    end, Graph, Edges).

dijkstra(N, Graph) ->
    Dist = array:new([{size, N}, {default, infinity}]),
    Dist1 = array:set(0, 0, Dist),
    PQ = gb_sets:from_list([{0, 0}]),
    dijkstra_loop(PQ, Graph, Dist1).

dijkstra_loop(PQ, Graph, Dist) ->
    case gb_sets:is_empty(PQ) of
        true -> Dist;
        false ->
            {{D, U}, PQ1} = gb_sets:take_smallest(PQ),
            lists:foldl(fun(V, {PQAcc, DistAcc}) ->
                case D + 1 < array:get(V, DistAcc) of
                    true ->
                        DistNew = array:set(V, D + 1, DistAcc),
                        PQNew = gb_sets:add({D + 1, V}, PQAcc),
                        {PQNew, DistNew};
                    false ->
                        {PQAcc, DistAcc}
                end
            end, {PQ1, Dist}, array:get(U, Graph))
    end.