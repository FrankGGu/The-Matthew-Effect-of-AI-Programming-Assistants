-module(valid_after_substitutions).
-export([is_valid/1]).

is_valid(S) ->
  is_valid(S, []).

is_valid([], []) ->
  true;
is_valid([], _) ->
  false;
is_valid([$a | Rest], Acc) ->
  is_valid(Rest, [$a | Acc]);
is_valid([$b | Rest], [$a | Acc]) ->
  is_valid(Rest, [$b, $a | Acc]);
is_valid([$c | Rest], [$b, $a | Acc]) ->
  is_valid(Rest, Acc);
is_valid(_, _) ->
  false.