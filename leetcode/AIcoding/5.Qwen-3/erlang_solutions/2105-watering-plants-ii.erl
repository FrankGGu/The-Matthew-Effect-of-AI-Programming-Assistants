-module(watering_plants_ii).
-export([completeCircuit/1]).

completeCircuit(Plants) ->
    TotalWater = lists:sum(Plants),
    CurrentWater = 0,
    Start = 0,
    completeCircuit(Plants, TotalWater, CurrentWater, Start).

completeCircuit([], _, _, Start) ->
    Start;
completeCircuit([H | T], TotalWater, CurrentWater, Start) ->
    case CurrentWater + H of
        N when N >= TotalWater ->
            Start;
        _ ->
            completeCircuit(T, TotalWater, CurrentWater + H - 1, Start)
    end.