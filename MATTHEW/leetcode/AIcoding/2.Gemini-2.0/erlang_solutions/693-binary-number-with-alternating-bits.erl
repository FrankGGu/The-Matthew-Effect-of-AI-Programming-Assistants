-module(alternating_bits).
-export([has_alternating_bits/1]).

has_alternating_bits(N) ->
  Bits = integer_to_list(N, 2),
  has_alternating_bits_helper(Bits).

has_alternating_bits_helper([]) ->
  true;
has_alternating_bits_helper([_]) ->
  true;
has_alternating_bits_helper([H1, H2 | T]) ->
  case H1 /= H2 of
    true ->
      has_alternating_bits_helper([H2 | T]);
    false ->
      false
  end.