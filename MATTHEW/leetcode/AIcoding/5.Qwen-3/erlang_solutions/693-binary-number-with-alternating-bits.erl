-module(alternating_bits).
-export([has_alternating_bits/1]).

has_alternating_bits(N) ->
    has_alternating_bits(N, N band 1).

has_alternating_bits(0, _) ->
    true;
has_alternating_bits(N, PrevBit) ->
    CurrentBit = N band 1,
    if
        CurrentBit == PrevBit ->
            false;
        true ->
            has_alternating_bits(N bsr 1, CurrentBit)
    end.