-module(solution).
-export([bitwiseComplement/1]).

bitwiseComplement(0) ->
    1;
bitwiseComplement(N) when N > 0 ->
    Mask = get_mask(N, 1),
    Mask bxor N.

get_mask(N, CurrentMask) when CurrentMask < N ->
    get_mask(N, (CurrentMask bsl 1) bor 1);
get_mask(_N, CurrentMask) ->
    CurrentMask.