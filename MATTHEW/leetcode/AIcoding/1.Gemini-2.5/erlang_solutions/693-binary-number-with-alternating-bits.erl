-module(solution).
-export([hasAlternatingBits/1]).

hasAlternatingBits(N) ->
    PrevBit = N band 1,
    hasAlternatingBits_helper(N bsr 1, PrevBit).

hasAlternatingBits_helper(0, _PrevBit) ->
    true;
hasAlternatingBits_helper(N, PrevBit) ->
    CurrentBit = N band 1,
    if
        CurrentBit == PrevBit ->
            false;
        true ->
            hasAlternatingBits_helper(N bsr 1, CurrentBit)
    end.