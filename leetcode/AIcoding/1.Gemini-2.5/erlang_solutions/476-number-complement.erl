-module(solution).
-export([numberComplement/1]).

numberComplement(Num) ->
    Mask = calculate_mask(1, Num),
    Num bxor Mask.

calculate_mask(I, Num) when I =< Num ->
    calculate_mask(I bsl 1, Num);
calculate_mask(I, _Num) ->
    I - 1.