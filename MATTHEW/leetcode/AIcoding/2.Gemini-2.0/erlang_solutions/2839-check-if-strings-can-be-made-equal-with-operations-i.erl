-module(solution).
-export([can_be_equal/2]).

can_be_equal(S1, S2) ->
  case lists:sort(S1) =:= lists:sort(S2) of
    true ->
      true;
    false ->
      false
  end.