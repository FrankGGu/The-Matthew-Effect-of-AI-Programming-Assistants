-module(number_of_common_factors).
-export([common_factors/2]).

common_factors(A, B) ->
  common_factors(A, B, 1, 0).

common_factors(A, B, I, Count) when I > min(A,B) ->
  Count;
common_factors(A, B, I, Count) ->
  case (A rem I =:= 0) and (B rem I =:= 0) of
    true ->
      common_factors(A, B, I+1, Count+1);
    false ->
      common_factors(A, B, I+1, Count)
  end.