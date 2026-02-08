-module(solution).
-export([convert_to_base7/1]).

convert_to_base7(N) ->
    convert_to_base7(N, []).

convert_to_base7(0, Acc) ->
    lists:reverse(Acc);
convert_to_base7(N, Acc) when N < 0 ->
    convert_to_base7(-N, [$- | Acc]);
convert_to_base7(N, Acc) ->
    convert_to_base7(N div 7, [digit(N rem 7) | Acc]).

digit(D) when D < 10 -> $0 + D;
digit(D) -> $a + D - 10.