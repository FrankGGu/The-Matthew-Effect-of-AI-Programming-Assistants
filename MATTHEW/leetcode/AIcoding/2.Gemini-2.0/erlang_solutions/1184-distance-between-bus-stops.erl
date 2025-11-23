-module(distance_between_bus_stops).
-export([distance_between_bus_stops/3]).

distance_between_bus_stops(Distance, Start, Destination) ->
  N = length(Distance),
  Forward_Distance = calculate_distance(Distance, Start, Destination, N),
  Total_Distance = lists:sum(Distance),
  min(Forward_Distance, Total_Distance - Forward_Distance).

calculate_distance(Distance, Start, Destination, N) ->
  case Start =< Destination of
    true ->
      lists:sum(lists:sublist(Distance, Start + 1, Destination - Start));
    false ->
      lists:sum(lists:sublist(Distance, Destination + 1, Start - Destination))
  end.