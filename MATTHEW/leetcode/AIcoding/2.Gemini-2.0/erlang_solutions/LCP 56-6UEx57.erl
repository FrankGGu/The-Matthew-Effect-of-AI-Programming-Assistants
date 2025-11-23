-module(solution).
-export([transport_gifts/1]).

transport_gifts(gifts) ->
  transport_gifts(gifts, 0, 0).

transport_gifts([], Count, _) ->
  Count;
transport_gifts([H|T], Count, Prev) ->
  case H >= Prev of
    true ->
      transport_gifts(T, Count + 1, H);
    false ->
      transport_gifts(T, Count, Prev)
  end.