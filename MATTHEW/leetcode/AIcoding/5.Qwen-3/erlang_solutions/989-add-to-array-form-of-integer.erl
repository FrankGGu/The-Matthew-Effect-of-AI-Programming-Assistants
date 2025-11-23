-module(solution).
-export([add_to_array_form/2]).

add_to_array_form(Num, K) ->
    List = lists:reverse(Num),
    Result = add(List, K, 0),
    lists:reverse(Result).

add([], 0, Carry) ->
    if Carry > 0 -> [Carry];
       true -> []
    end;
add([], K, Carry) ->
    add([], K div 10, Carry + K rem 10);
add([H | T], K, Carry) ->
    Sum = H + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    case K of
        0 ->
            add(T, 0, NewCarry + Digit);
        _ ->
            NextDigit = K rem 10,
            NewSum = Digit + NextDigit,
            NewDigit = NewSum rem 10,
            NewNewCarry = NewSum div 10 + NewCarry,
            [NewDigit | add(T, K div 10, NewNewCarry)]
    end.