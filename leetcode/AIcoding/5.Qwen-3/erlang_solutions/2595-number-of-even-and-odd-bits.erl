-module(even_odd_bits).
-export([evenOddBit/1]).

evenOddBit(Num) ->
    Even = 0,
    Odd = 0,
    evenOddBit(Num, Even, Odd).

evenOddBit(0, Even, Odd) ->
    [Even, Odd];
evenOddBit(Num, Even, Odd) ->
    Bit = Num band 1,
    case (Bit rem 2) of
        0 -> evenOddBit(Num bsr 1, Even + 1, Odd);
        _ -> evenOddBit(Num bsr 1, Even, Odd + 1)
    end.