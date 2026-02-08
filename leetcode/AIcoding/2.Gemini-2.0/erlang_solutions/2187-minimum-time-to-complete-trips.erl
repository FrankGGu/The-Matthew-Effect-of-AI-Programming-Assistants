-module(minimum_time_to_complete_trips).
-export([minimum_time/2]).

minimum_time(Trips, Time) ->
  lists:sort(Time),
  L = lists:nth(1, Time),
  R = element(length(Time), lists:sort(Time)) * Trips,
  binary_search(L, R, Trips, Time).

binary_search(L, R, Trips, Time) ->
  if
    L =:= R ->
      L;
    true ->
      Mid = L + (R - L) div 2,
      if
        check(Mid, Trips, Time) ->
          binary_search(L, Mid, Trips, Time);
        false ->
          binary_search(Mid + 1, R, Trips, Time)
      end
  end.

check(T, Trips, Time) ->
  Sum = lists:sum([T div X || X <- Time]),
  Sum >= Trips.