-module(find_divisibility_array).
-export([divisibility_array/2]).

divisibility_array(Num, Divisor) ->
    divisibility_array(Num, Divisor, 0, []).

divisibility_array([], _, _, Acc) ->
    lists:reverse(Acc);
divisibility_array([H|T], Divisor, Remainder, Acc) ->
    NewRemainder = (Remainder * 10 + H - $0) rem Divisor,
    case NewRemainder of
        0 ->
            divisibility_array(T, Divisor, NewRemainder, [1|Acc]);
        _ ->
            divisibility_array(T, Divisor, NewRemainder, [0|Acc])
    end.

divisibility_array(NumStr, Divisor) ->
    Num = string:to_list(NumStr),
    divisibility_array(Num, Divisor).