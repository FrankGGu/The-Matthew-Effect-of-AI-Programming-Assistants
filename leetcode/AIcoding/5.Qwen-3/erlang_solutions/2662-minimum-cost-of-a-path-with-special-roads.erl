-module(minimum_cost_of_a_path_with_special_roads).
-export([minimumCost/2]).

minimumCost(Start, Target) ->
    {X1, Y1} = Start,
    {X2, Y2} = Target,
    {X1, Y1, X2, Y2} = {X1, Y1, X2, Y2},
    dijkstra({X1, Y1}, {X2, Y2}).

dijkstra(Start, Target) ->
    Directions = [{0, 1}, {1, 0}, {-1, 0}, {0, -1}],
    SpecialRoads = [],
    Visited = sets:new(),
    Distances = dict:store(Start, 0, dict:new()),
    Queue = erlang:priority_queue:new([{0, Start}]),
    dijkstra_loop(Queue, Distances, Visited, Target, Directions, SpecialRoads).

dijkstra_loop(Queue, Distances, Visited, Target, Directions, _) when erlang:priority_queue:is_empty(Queue) ->
    dict:fetch(Target, Distances).

dijkstra_loop(Queue, Distances, Visited, Target, Directions, SpecialRoads) ->
    {Cost, Current} = erlang:priority_queue:pop(Queue),
    case sets:is_element(Current, Visited) of
        true -> dijkstra_loop(Queue, Distances, Visited, Target, Directions, SpecialRoads);
        false ->
            NewVisited = sets:add_element(Current, Visited),
            case Current of
                Target -> Cost;
                _ ->
                    Neighbors = generate_neighbors(Current, Directions),
                    UpdatedDistances = update_distances(Neighbors, Current, Cost, Distances),
                    NewQueue = add_to_queue(Neighbors, UpdatedDistances, Queue),
                    dijkstra_loop(NewQueue, UpdatedDistances, NewVisited, Target, Directions, SpecialRoads)
            end
    end.

generate_neighbors({X, Y}, Directions) ->
    [ {X + DX, Y + DY} || {DX, DY} <- Directions ].

update_distances([], _, _, Distances) -> Distances;
update_distances([Neighbor | Rest], Current, Cost, Distances) ->
    NewCost = Cost + 1,
    case dict:is_key(Neighbor, Distances) of
        true ->
            ExistingCost = dict:fetch(Neighbor, Distances),
            if NewCost < ExistingCost ->
                update_distances(Rest, Current, Cost, dict:store(Neighbor, NewCost, Distances));
            true ->
                update_distances(Rest, Current, Cost, Distances)
            end;
        false ->
            update_distances(Rest, Current, Cost, dict:store(Neighbor, NewCost, Distances))
    end.

add_to_queue([], _, Queue) -> Queue;
add_to_queue([Neighbor | Rest], Distances, Queue) ->
    Cost = dict:fetch(Neighbor, Distances),
    NewQueue = erlang:priority_queue:in({Cost, Neighbor}, Queue),
    add_to_queue(Rest, Distances, NewQueue).