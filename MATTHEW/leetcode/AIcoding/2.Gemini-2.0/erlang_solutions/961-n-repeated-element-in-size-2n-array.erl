-module(n_repeated_element).
-export([repeated_n_times/1]).

repeated_n_times(A) ->
  repeated_n_times(A, sets:new()).

repeated_n_times([], _) ->
  none;
repeated_n_times([H|T], Seen) ->
  case sets:is_element(H, Seen) of
    true ->
      H;
    false ->
      repeated_n_times(T, sets:add_element(H, Seen))
  end.