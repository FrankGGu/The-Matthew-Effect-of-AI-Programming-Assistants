-module(find_encrypted_string).
-export([solve/1]).

solve(S) ->
  find_encrypted_string(S, []).

find_encrypted_string([], Acc) ->
  lists:reverse(Acc);
find_encrypted_string([H|T], Acc) ->
  find_encrypted_string(T, [H|Acc]).