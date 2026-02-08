-module(solution).
-export([minimizeXor/2]).

-spec minimizeXor(Num1 :: integer(), Num2 :: integer()) -> integer().
minimizeXor(Num1, Num2) ->
    K = erlang:popcount(Num2),

    {X1, K1} = set_bits_from_num1(Num1, K, 0, 63), 

    X2 = set_bits_not_in_num1(Num1, K1, X1, 0),
    X2.

set_bits_from_num1(Num1, RemainingK, CurrentX, BitPos) when BitPos >= 0 ->
    if
        RemainingK =< 0 ->
            {CurrentX, RemainingK};
        (Num1 band (1 bsl BitPos)) /= 0 ->
            set_bits_from_num1(Num1, RemainingK - 1, CurrentX bor (1 bsl BitPos), BitPos - 1);
        true ->
            set_bits_from_num1(Num1, RemainingK, CurrentX, BitPos - 1)
    end;
set_bits_from_num1(_Num1, RemainingK, CurrentX, _BitPos) ->
    {CurrentX, RemainingK}.

set_bits_not_in_num1(Num1, RemainingK, CurrentX, BitPos) when BitPos <= 63 ->
    if
        RemainingK =< 0 ->
            CurrentX;
        (Num1 band (1 bsl BitPos)) == 0 ->
            set_bits_not_in_num1(Num1, RemainingK - 1, CurrentX bor (1 bsl BitPos), BitPos + 1);
        true ->
            set_bits_not_in_num1(Num1, RemainingK, CurrentX, BitPos + 1)
    end;
set_bits_not_in_num1(_Num1, _RemainingK, CurrentX, _BitPos) ->
    CurrentX.