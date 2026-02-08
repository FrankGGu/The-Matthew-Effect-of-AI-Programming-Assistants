-module(alternating_colors).
-export([shortest_path/1]).

shortest_path(Graph) ->
    Colors = 3,
    N = length(Graph),
    Dist = array:new(N, {default, -1}),
    Queue = queue:from_list([{0, 0}]),
    Dist1 = array:set(0, 0, Dist),
    BFS(Queue, Dist1, Graph, 0, Colors).

BFS(Q, Dist, Graph, Color, Colors) ->
    case queue:out(Q) of
        {empty, _} -> Dist;
        {{value, {Node, CurrentColor}}, NewQ} ->
            NextColor = (CurrentColor + 1) rem Colors,
            lists:foreach(fun({Neighbor, EdgeColor}) ->
                              if
                                  EdgeColor == NextColor ->
                                      case array:get(Neighbor, Dist) of
                                          -1 ->
                                              NewDist = array:set(Neighbor, array:get(Node, Dist) + 1, Dist),
                                              BFS(queue:in({Neighbor, NextColor}, NewQ), NewDist, Graph, NextColor, Colors);
                                          _ ->
                                              ok
                                      end;
                                  true ->
                                      ok
                              end
                          end, lists:nth(Node + 1, Graph)),
            BFS(NewQ, Dist, Graph, Color, Colors)
    end.