-module(heaters).
-export([find_radius/2]).

find_radius(Houses, Heaters) ->
  lists:sort(Houses, fun(A, B) -> A < B end) -> Sorted_Houses,
  lists:sort(Heaters, fun(A, B) -> A < B end) -> Sorted_Heaters,
  find_max_radius(Sorted_Houses, Sorted_Heaters, 0).

find_max_radius([], _, Max_Radius) ->
  Max_Radius;
find_max_radius([House | Rest_Houses], Heaters, Max_Radius) ->
  Radius = find_min_radius(House, Heaters),
  New_Max_Radius = max(Max_Radius, Radius),
  find_max_radius(Rest_Houses, Heaters, New_Max_Radius).

find_min_radius(House, Heaters) ->
  find_closest_heater(House, Heaters, infinity).

find_closest_heater(House, [], Min_Distance) ->
  Min_Distance;
find_closest_heater(House, [Heater | Rest_Heaters], Min_Distance) ->
  Distance = abs(House - Heater),
  New_Min_Distance = min(Min_Distance, Distance),
  find_closest_heater(House, Rest_Heaters, New_Min_Distance).

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.

min(A, B) ->
  if
    A < B -> A;
    true -> B
  end.

infinity() -> 16#7fffffff#.