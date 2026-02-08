-module(corporate_flight_bookings).
-export([corpFlightBookings/2]).

corpFlightBookings(bookings, n) ->
  lists:foldl(
    fun([i, j, k], Acc) ->
      update_range(i, j, k, Acc)
    end,
    lists:duplicate(n, 0),
    bookings
  ).

update_range(I, J, K, Acc) ->
  update_range(I, J, K, Acc, 1).

update_range(I, J, K, Acc, Index) ->
  case Acc of
    [] ->
      [];
    [H|T] ->
      if
        Index >= I, Index =< J ->
          [H + K | update_range(I, J, K, T, Index + 1)];
        true ->
          [H | update_range(I, J, K, T, Index + 1)]
      end
  end.