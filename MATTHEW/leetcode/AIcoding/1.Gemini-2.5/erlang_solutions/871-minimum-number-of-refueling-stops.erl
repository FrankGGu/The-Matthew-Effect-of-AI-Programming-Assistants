-module(solution).
-export([min_refuel_stops/3]).

min_refuel_stops(Target, StartFuel, Stations) ->
    solve(Target, StartFuel, 0, gb_trees:empty(), Stations).

solve(Target, CurrentFuel, Stops, PassedStationsFuel, RemainingStations) ->
    if CurrentFuel >= Target ->
        Stops;
    true ->
        [UpdatedHeap, UnreachableStations] =
            collect_reachable_stations(CurrentFuel, RemainingStations, PassedStationsFuel),
        case extract_max_fuel(UpdatedHeap) of
            {none, _} ->
                -1;
            {RefuelAmount, HeapAfterExtraction} ->
                solve(Target, CurrentFuel + RefuelAmount, Stops + 1, HeapAfterExtraction, UnreachableStations)
        end
    end.

collect_reachable_stations(MaxReach, [H|T]=Stations, AccHeap) ->
    {StationPos, StationFuel} = H,
    if StationPos =< MaxReach ->
        NewHeap = add_fuel(StationFuel, AccHeap),
        collect_reachable_stations(MaxReach, T, NewHeap);
    true ->
        [AccHeap, Stations]
    end;
collect_reachable_stations(_, [], AccHeap) ->
    [AccHeap, []].

add_fuel(Fuel, Tree) ->
    case gb_trees:lookup(Fuel, Tree) of
        {value, Count} -> gb_trees:update(Fuel, Count + 1, Tree);
        none -> gb_trees:insert(Fuel, 1, Tree)
    end.

extract_max_fuel(Tree) ->
    case gb_trees:is_empty(Tree) of
        true -> {none, Tree};
        false ->
            {MaxFuel, Count, TreeWithoutMax} = gb_trees:take_max(Tree),
            if Count > 1 -> {MaxFuel, gb_trees:insert(MaxFuel, Count - 1, TreeWithoutMax)};
               true -> {MaxFuel, TreeWithoutMax}
            end
    end.