-module(harshad_number).
-export([is_harshad/1]).

is_harshad(N) ->
    IsPositive = N > 0,
    if
        not IsPositive -> false;
        true ->
            Digits = integer_to_list(N),
            Sum = lists:foldl(fun(D, Acc) -> Acc + (D - $0) end, 0, Digits),
            Sum =/= 0 andalso N rem Sum == 0
    end.