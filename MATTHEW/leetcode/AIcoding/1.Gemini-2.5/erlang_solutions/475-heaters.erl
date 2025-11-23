-module(solution).
-export([findRadius/2]).

findRadius(Houses, Heaters) ->
    SortedHouses = lists:sort(Houses),
    SortedHeaters = lists:sort(Heaters),

    % The main recursive function iterates through houses.
    % It maintains the current heater 'pointer' (CurrentHeater and RemainingHeaters)
    % and the maximum radius found so far.
    find_radius_recursive(SortedHouses, hd(SortedHeaters), tl(SortedHeaters), 0).

find_radius_recursive([], _CurrentHeater, _RemainingHeaters, MaxRadius) ->
    MaxRadius;
find_radius_recursive([House | RestHouses], CurrentHeater, RemainingHeaters, CurrentMaxRadius) ->
    % For the current House, find the minimum distance to an optimal heater.
    % Also, update the heater pointer (NewCurrentHeater, NewRemainingHeaters)
    % for the next house.
    {MinDistForHouse, NewCurrentHeater, NewRemainingHeaters} =
        get_best_heater_for_house(House, CurrentHeater, RemainingHeaters),

    NewMaxRadius = max(CurrentMaxRadius, MinDistForHouse),

    find_radius_recursive(RestHouses, NewCurrentHeater, NewRemainingHeaters, NewMaxRadius).

get_best_heater_for_house(House, CurrentHeater, []) ->
    % No more heaters to the right. CurrentHeater is the only option.
    % The heater pointer does not change for the next house.
    {abs(House - CurrentHeater), CurrentHeater, []};
get_best_heater_for_house(House, CurrentHeater, [NextHeater | RestHeaters]) ->
    DistCurrent = abs(House - CurrentHeater),
    DistNext = abs(House - NextHeater),

    if
        DistCurrent < DistNext ->
            % CurrentHeater is better. Do not advance the heater pointer for this house.
            % The next house will also start comparing with CurrentHeater.
            {DistCurrent, CurrentHeater, [NextHeater | RestHeaters]};
        true -> % DistNext <= DistCurrent
            % NextHeater is better or equally good. Advance the heater pointer.
            % Recurse with NextHeater as the new CurrentHeater.
            get_best_heater_for_house(House, NextHeater, RestHeaters)
    end.