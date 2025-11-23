-module(solution).
-export([find_radius/2]).

-spec find_radius([integer()], [integer()]) -> integer().
find_radius(Houses, Heaters) ->
    %% Sort the houses and heaters arrays for binary search.
    SortedHouses = lists:sort(Houses),
    SortedHeaters = lists:sort(Heaters),
    %% Find the minimum radius for all houses.
    lists:max([find_closest_heater(House, SortedHeaters) || House <- SortedHouses]).

%% Helper function to find the closest heater for a given house.
-spec find_closest_heater(integer(), [integer()]) -> integer().
find_closest_heater(House, Heaters) ->
    %% Perform a binary search to find the closest heater.
    ClosestHeaterIndex = find_closest_index(House, Heaters),
    %% Get the closest heater's distance.
    Heater = lists:nth(ClosestHeaterIndex, Heaters),
    abs(Heater - House).

%% Binary search to find the index of the closest heater.
-spec find_closest_index(integer(), [integer()]) -> integer().
find_closest_index(House, Heaters) ->
    find_closest_index(House, Heaters, 1, length(Heaters)).

-spec find_closest_index(integer(), [integer()], integer(), integer()) -> integer().
find_closest_index(House, Heaters, Low, High) when Low == High ->
    Low;
find_closest_index(House, Heaters, Low, High) ->
    Mid = (Low + High) div 2,
    HeaterAtMid = lists:nth(Mid, Heaters),
    case HeaterAtMid of
        Heater when Heater == House -> Mid;
        Heater when Heater < House -> find_closest_index(House, Heaters, Mid + 1, High);
        _ -> find_closest_index(House, Heaters, Low, Mid)
    end.
