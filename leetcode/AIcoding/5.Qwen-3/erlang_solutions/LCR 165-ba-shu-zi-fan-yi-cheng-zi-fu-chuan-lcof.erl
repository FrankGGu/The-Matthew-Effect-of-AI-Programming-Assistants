-module(solution).
-export([decode_int/1]).

decode_int(Num) ->
    decode_int(Num, []).

decode_int(0, Acc) ->
    lists:reverse(Acc);
decode_int(Num, Acc) ->
    Digit = Num rem 10,
    NewAcc = case Digit of
        0 -> [0 | Acc];
        _ -> [Digit + 3 | Acc]
    end,
    decode_int(Num div 10, NewAcc).