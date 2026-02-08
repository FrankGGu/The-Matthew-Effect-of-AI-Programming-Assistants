-module(to_lower_case).
-export([to_lower_case/1]).

to_lower_case(S) ->
  list_to_binary([to_lower(C) || C <- binary_to_list(S)]).

to_lower(C) when C >= $A, C =< $Z ->
  C + 32;
to_lower(C) ->
  C.