-module(solution).
-export([solve/5]).

solve(N, Roads, Start, End, MaxBattery) ->
    Adj = build_adj(Roads),

    % Dist: map of {{Node, BatteryLevel} => MinEnergyConsumed}
    % Initialize with infinity for all states except the start state.
    Dist = maps:new(),

    % PQ: gb_trees used as a min-priority queue.
    % Keys are {EnergyConsumed, Node, BatteryLevel}
    % Values are 'true' (or anything, as we only care about the keys for ordering).
    PQ = gb_trees:empty(),

    % Initial state: 0 energy consumed, at Start node, with MaxBattery.
    InitialDist = maps:put({Start, MaxBattery}, 0, Dist),
    InitialPQ = gb_trees:insert({0, Start, MaxBattery}, true, PQ),

    dijkstra(InitialPQ, InitialDist, Adj, End, MaxBattery).

build_adj(Roads) ->
    lists:foldl(fun([U, V, Cost], Acc) ->
        maps:update_with(U, fun(List) -> [{V, Cost} | List] end, [{V, Cost}], Acc)
    end, maps:new(), Roads).

dijkstra(PQ, Dist, Adj, End, MaxBattery) ->
    case gb_trees:is_empty(PQ) of
        true ->
            % Priority queue is empty, no more reachable states.
            % Find the minimum energy to reach the End node with any battery level.
            min_energy_at_end(Dist, End);
        false ->
            % Pop the state with the smallest energy consumed from the priority queue.
            {{Energy, U, B}, _, NewPQ} = gb_trees:take_smallest(PQ),

            % If we have already found a shorter path to this state (U, B), skip.
            case maps:get({U, B}, Dist, infinity()) of
                CurrentMinEnergy when Energy > CurrentMinEnergy ->
                    dijkstra(NewPQ, Dist, Adj, End, MaxBattery);
                _ ->
                    % Process neighbors of U
                    Neighbors = maps:get(U, Adj, []),
                    {UpdatedPQ, UpdatedDist} = lists:foldl(fun({V, Cost_uv}, {AccPQ, AccDist}) ->
                        if B >= Cost_uv -> % Check if enough battery to travel
                            NewBattery = B - Cost_uv,
                            NewEnergy = Energy + Cost_uv,
                            CurrentMinEnergyV = maps:get({V, NewBattery}, AccDist, infinity()),
                            if NewEnergy < CurrentMinEnergyV ->
                                % Found a shorter path to (V, NewBattery)
                                NewAccDist = maps:put({V, NewBattery}, NewEnergy, AccDist),
                                NewAccPQ = gb_trees:insert({NewEnergy, V, NewBattery}, true, AccPQ),
                                {NewAccPQ, NewAccDist};
                            true ->
                                % Not a shorter path, keep current state
                                {AccPQ, AccDist}
                            end;
                        true ->
                            % Not enough battery, cannot travel to V
                            {AccPQ, AccDist}
                        end
                    end, {NewPQ, Dist}, Neighbors),

                    % Continue Dijkstra's with updated PQ and Dist map
                    dijkstra(UpdatedPQ, UpdatedDist, Adj, End, MaxBattery)
            end
    end.

min_energy_at_end(Dist, End) ->
    MinEnergy = maps:fold(fun({Node, _Battery}, Energy, AccMin) ->
        if Node == End ->
            min(Energy, AccMin);
        true ->
            AccMin
        end
    end, infinity(), Dist),

    if MinEnergy == infinity() -> -1; % End city is not reachable
    true -> MinEnergy
    end.

infinity() -> 1 bsl 60.