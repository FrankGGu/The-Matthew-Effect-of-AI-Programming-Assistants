-module(solution).
-export([divide_nodes_into_the_maximum_number_of_groups/2]).

build_adj(N, Edges) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(L) -> [V | L] end, [V], Acc),
            maps:update_with(V, fun(L) -> [U | L] end, [U], Acc1)
        end,
        maps:from_list([{I, []} || I <- lists:seq(1, N)]),
        Edges
    ).

find_component_and_check_bipartite(StartNode, Adj, GlobalVisited) ->
    Q = queue:in({StartNode, 0}, queue:new()), % {Node, Color}
    ComponentColors = #{StartNode => 0},
    CurrentVisited = sets:add_element(StartNode, sets:new()),
    ComponentNodes = [StartNode],

    bfs_bipartite_loop(Q, Adj, GlobalVisited, ComponentColors, CurrentVisited, ComponentNodes, true).

bfs_bipartite_loop(Q, Adj, GlobalVisited, ComponentColors, CurrentVisited, ComponentNodes, IsBipartite) ->
    case {queue:out(Q), IsBipartite} of
        {{empty, _}, _} ->
            {IsBipartite, sets:union(GlobalVisited, CurrentVisited), ComponentNodes};
        {_, false} -> 
            {false, sets:union(GlobalVisited, CurrentVisited), ComponentNodes}; 
        {{value, {Node, Color}, Q1}, true} ->
            NextColor = 1 - Color,
            Neighbors = maps:get(Node, Adj, []),

            {NewQ, NewComponentColors, NewCurrentVisited, NewComponentNodes, NewIsBipartite} =
                lists:foldl(
                    fun(Neighbor, {AccQ, AccComponentColors, AccCurrentVisited, AccComponentNodes, AccIsBipartite}) ->
                        case AccIsBipartite of
                            false -> 
                                {AccQ, AccComponentColors, AccCurrentVisited, AccComponentNodes, false};
                            true ->
                                case maps:is_key(Neighbor, AccComponentColors) of
                                    true ->
                                        case maps:get(Neighbor, AccComponentColors) == Color of
                                            true -> 
                                                {AccQ, AccComponentColors, AccCurrentVisited, AccComponentNodes, false};
                                            false -> 
                                                {AccQ, AccComponentColors, AccCurrentVisited, AccComponentNodes, AccIsBipartite}
                                        end;
                                    false -> 
                                        NewAccComponentColors = AccComponentColors#{Neighbor => NextColor},
                                        NewAccCurrentVisited = sets:add_element(Neighbor, AccCurrentVisited),
                                        NewAccQ = queue:in({Neighbor, NextColor}, AccQ),
                                        NewAccComponentNodes = [Neighbor | AccComponentNodes],
                                        {NewAccQ, NewAccComponentColors, NewAccCurrentVisited, NewAccComponentNodes, AccIsBipartite}
                                end
                        end
                    end,
                    {Q1, ComponentColors, CurrentVisited, ComponentNodes, IsBipartite},
                    Neighbors
                ),
            bfs_bipartite_loop(NewQ, Adj, GlobalVisited, NewComponentColors, NewCurrentVisited, NewComponentNodes, NewIsBipartite)
    end.

bfs_for_diameter(StartNode, Adj, ComponentNodesSet) ->
    Q = queue:in({StartNode, 0}, queue:new()), % {Node, Distance}
    VisitedInBFS = sets:add_element(StartNode, sets:new()),

    bfs_diameter_loop(Q, Adj, ComponentNodesSet, VisitedInBFS, StartNode, 0).

bfs_diameter_loop(Q, Adj, ComponentNodesSet, VisitedInBFS, FarthestNode, MaxDistance) ->
    case queue:out(Q) of
        {empty, _} ->
            {FarthestNode, MaxDistance};
        {value, {Node, Dist}, Q1} ->
            Neighbors = maps:get(Node, Adj, []),

            {NewQ, NewVisitedInBFS, NewFarthestNode, NewMaxDistance} =
                lists:foldl(
                    fun(Neighbor, {AccQ, AccVisitedInBFS, AccFarthestNode, AccMaxDistance}) ->
                        case {sets:is_element(Neighbor, ComponentNodesSet), sets:is_element(Neighbor, AccVisitedInBFS)} of
                            {true, false} -> 
                                NewDist = Dist + 1,
                                NewAccVisitedInBFS = sets:add_element(Neighbor, AccVisitedInBFS),
                                NewAccQ = queue:in({Neighbor, NewDist}, AccQ),

                                case NewDist > AccMaxDistance of
                                    true ->
                                        {NewAccQ, NewAccVisitedInBFS, Neighbor, NewDist};
                                    false ->
                                        {NewAccQ, NewAccVisitedInBFS, AccFarthestNode, AccMaxDistance}
                                end;
                            _ -> 
                                {AccQ, AccVisitedInBFS, AccFarthestNode, AccMaxDistance}
                        end
                    end,
                    {Q1, VisitedInBFS, FarthestNode, MaxDistance},
                    Neighbors
                ),
            bfs_diameter_loop(NewQ, Adj, ComponentNodesSet, NewVisitedInBFS, NewFarthestNode, NewMaxDistance)
    end.

divide_nodes_into_the_maximum_number_of_groups(N, Edges) ->
    Adj = build_adj(N, Edges),
    GlobalVisited = sets:new(),

    process_nodes(1, N, Adj, GlobalVisited, 0).

process_nodes(Node, N, Adj, GlobalVisited, TotalGroups) when Node =< N ->
    case sets:is_element(Node, GlobalVisited) of
        true ->
            process_nodes(Node + 1, N, Adj, GlobalVisited, TotalGroups);
        false ->
            {IsBipartite, NewGlobalVisited, ComponentNodes} = 
                find_component_and_check_bipartite(Node, Adj, GlobalVisited),

            case IsBipartite of
                false ->
                    -1; 
                true ->
                    ComponentNodesSet = sets:from_list(ComponentNodes),

                    Diameter = case ComponentNodes of
                                   [] -> 0; 
                                   [_] -> 0; 
                                   [H|_] -> 
                                       {Farthest1, _} = bfs_for_diameter(H, Adj, ComponentNodesSet),
                                       {_Farthest2, D} = bfs_for_diameter(Farthest1, Adj, ComponentNodesSet),
                                       D
                               end,

                    NewTotalGroups = TotalGroups + Diameter + 1,
                    process_nodes(Node + 1, N, Adj, NewGlobalVisited, NewTotalGroups)
            end
    end;
process_nodes(_Node, _N, _Adj, _GlobalVisited, TotalGroups) ->
    TotalGroups.