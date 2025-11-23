-module(multiply_strings).
-export([multiply/2]).

multiply("0", _) -> "0";
multiply(_, "0") -> "0";
multiply(A, B) ->
    ALen = length(A),
    BLen = length(B),
    Result = lists:duplicate(ALen + BLen, $0),
    multiply(A, B, ALen - 1, BLen - 1, Result).

multiply(_, _, -1, _, Result) -> lists:reverse(Result);
multiply(A, B, I, J, Result) ->
    DigitA = erlang:element(I + 1, list_to_tuple(A)) - $0,
    DigitB = erlang:element(J + 1, list_to_tuple(B)) - $0,
    Product = DigitA * DigitB,
    Index = I + J + 2,
    Current = erlang:element(Index, list_to_tuple(Result)),
    NewVal = Current + Product,
    Carry = NewVal div 10,
    NewDigit = NewVal rem 10,
    UpdatedResult = set_element(Index, Result, NewDigit + $0),
    if
        Carry > 0 ->
            multiply(A, B, I, J - 1, update_carry(UpdatedResult, Index - 1, Carry));
        true ->
            multiply(A, B, I, J - 1, UpdatedResult)
    end.

update_carry(Result, Index, Carry) when Index >= 0 ->
    Current = erlang:element(Index + 1, list_to_tuple(Result)),
    NewVal = Current + Carry,
    NewDigit = NewVal rem 10,
    CarryOut = NewVal div 10,
    UpdatedResult = set_element(Index + 1, Result, NewDigit + $0),
    update_carry(UpdatedResult, Index - 1, CarryOut);
update_carry(Result, _, _) -> Result.