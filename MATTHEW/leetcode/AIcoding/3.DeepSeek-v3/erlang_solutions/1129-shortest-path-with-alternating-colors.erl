-module(solution).
-export([shortest_alternating_paths/3]).

shortest_alternating_paths(N, RedEdges, BlueEdges) ->
    RedAdj = build_adj(N, RedEdges),
    BlueAdj = build_adj(N, BlueEdges),
    Dist = array:new([{size, N}, {default, -1}]),
    Visited = sets:new(),
    Queue = queue:new(),
    Queue1 = queue:in({0, red}, Queue),
    Queue2 = queue:in({0, blue}, Queue1),
    Dist1 = array:set(0, 0, Dist),
    bfs(Queue2, RedAdj, BlueAdj, Dist1, Visited).

build_adj(N, Edges) ->
    Adj = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
                        Neighbors = array:get(U, Acc),
                        array:set(U, [V | Neighbors], Acc)
                end, Adj, Edges).

bfs(Queue, RedAdj, BlueAdj, Dist, Visited) ->
    case queue:is_empty(Queue) of
        true -> array:to_list(Dist);
        false ->
            {{value, {Node, Color}}, Q1} = queue:out(Queue),
            Adj = case Color of
                       red -> BlueAdj;
                       blue -> RedAdj
                   end,
            Neighbors = array:get(Node, Adj),
            lists:foldl(fun(Neighbor, {Q, D, V}) ->
                                case sets:is_element({Neighbor, Color}, V) of
                                    true -> {Q, D, V};
                                    false ->
                                        NewDist = array:get(Node, D) + 1,
                                        case array:get(Neighbor, D) of
                                            -1 -> 
                                                D1 = array:set(Neighbor, NewDist, D),
                                                V1 = sets:add_element({Neighbor, opposite_color(Color)}, V),
                                                Q1 = queue:in({Neighbor, opposite_color(Color)}, Q),
                                                {Q1, D1, V1};
                                            _ ->
                                                V1 = sets:add_element({Neighbor, opposite_color(Color)}, V),
                                                Q1 = queue:in({Neighbor, opposite_color(Color)}, Q),
                                                {Q1, D, V1}
                                        end
                                end
                        end, {Q1, Dist, Visited}, Neighbors),
            bfs(Q1, RedAdj, BlueAdj, Dist, Visited)
    end.

opposite_color(red) -> blue;
opposite_color(blue) -> red.