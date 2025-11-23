-module(solution).
-export([max_probability/3]).

max_probability(Edges, From, To) ->
    Graph = build_graph(Edges),
    D = dict:new(),
    {MaxProb, _} = dijkstra(Graph, From, To, D, 1.0),
    if MaxProb == 0 -> 0.0; true -> MaxProb end.

build_graph(Edges) ->
    Graph = dict:new(),
    lists:foldl(fun({U, V, P}, Acc) ->
        Acc1 = dict:update(U, [{V, P}], fun(L) -> [{V, P} | L] end, Acc),
        dict:update(V, [{U, P}], fun(L) -> [{U, P} | L] end, Acc1)
    end, Graph, Edges).

dijkstra(Graph, From, To, Dist, Prob) ->
    case dict:find(From, Dist) of
        undefined -> 
            {Prob, Dist};
        _ ->
            {Next, NewDist} = next_node(Graph, Dist),
            if Next == To -> 
                {Prob * dict:find(Next, Dist), NewDist};
            true ->
                NewProb = Prob * dict:find(Next, Dist),
                dijkstra(Graph, Next, To, NewDist, NewProb)
            end
    end.

next_node(Graph, Dist) ->
    lists:foldl(fun({Key, Value}, {BestKey, BestProb}) ->
        case dict:find(Key, Dist) of
            undefined -> {BestKey, BestProb};
            Prob when Prob > BestProb -> {Key, Prob};
            _ -> {BestKey, BestProb}
        end
    end, {undefined, 0}, dict:to_list(Graph)).