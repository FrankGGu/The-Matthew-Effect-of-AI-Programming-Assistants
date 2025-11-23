-module(minimum_cost_walk).
-export([min_cost/2]).

min_cost(Graph, K) ->
    {Nodes, Edges} = parse_graph(Graph),
    Size = length(Nodes),
    Dist = array:new(Size, {default, 1000000}),
    array:set(0, 0, Dist),
    do_relax(Edges, Dist, K).

do_relax(_, Dist, 0) ->
    array:get(Size - 1, Dist);
do_relax(Edges, Dist, K) ->
    NewDist = array:new(array:size(Dist), {default, 1000000}),
    lists:foreach(fun({U, V, W}) ->
        if
            array:get(U, Dist) + W < array:get(V, NewDist) ->
                array:set(V, array:get(U, Dist) + W, NewDist);
            true ->
                NewDist
        end
    end, Edges),
    do_relax(Edges, NewDist, K - 1).

parse_graph(Graph) ->
    Nodes = lists:seq(0, length(Graph) - 1),
    Edges = lists:foldl(fun({From, To, Weight}, Acc) ->
        [{From, To, Weight} | Acc]
    end, [], Graph),
    {Nodes, Edges}.