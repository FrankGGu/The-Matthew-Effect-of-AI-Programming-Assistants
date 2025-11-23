-module(percentage_of_letter).
-export([percentage_letter/2]).

percentage_letter(S, Letter) ->
  Len = length(S),
  Count = length([X || X <- S, X == Letter]),
  case Len > 0 of
    true ->
      round((Count / Len) * 100);
    false ->
      0
  end.