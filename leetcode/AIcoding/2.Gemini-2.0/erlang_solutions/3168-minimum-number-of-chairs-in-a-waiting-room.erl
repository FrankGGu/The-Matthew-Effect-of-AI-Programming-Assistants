-module(min_chairs).
-export([min_meeting_rooms/1]).

min_meeting_rooms(Arrivals) ->
  SortedArrivals = lists:sort(Arrivals),
  {_, MaxOverlap} = lists:foldl(
    fun(Arrival, {Occupied, Max}) ->
      {NewOccupied, NewMax} = update_occupied(Arrival, Occupied, Max);
      {NewOccupied, NewMax}
    end,
    {[], 0},
    SortedArrivals
  ),
  MaxOverlap.

update_occupied(Arrival, Occupied, Max) ->
  FreeChairs = lists:filter(fun(Departure) -> Departure =< Arrival end, Occupied),
  NewOccupied = lists:subtract(Occupied, FreeChairs) ++ [Arrival + 1],
  NewMax = max(length(NewOccupied), Max),
  {NewOccupied, NewMax}.

max(A, B) ->
  if A > B -> A;
     true -> B
  end.