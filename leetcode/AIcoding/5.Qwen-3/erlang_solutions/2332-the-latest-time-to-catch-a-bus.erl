-module(solution).
-export([latest_time_to_catch_a_bus/2]).

latest_time_to_catch_a_bus(People, Buses) ->
    SortedPeople = lists:sort(People),
    SortedBuses = lists:sort(Buses),
    catch_bus(SortedPeople, SortedBuses, 0).

catch_bus([], _, Acc) ->
    Acc;
catch_bus([P | Ps], [B | Bs], Acc) when P =< B ->
    catch_bus(Ps, Bs, B);
catch_bus([P | Ps], [B | Bs], Acc) ->
    catch_bus([P | Ps], Bs, Acc);
catch_bus([P | Ps], [], Acc) ->
    P.