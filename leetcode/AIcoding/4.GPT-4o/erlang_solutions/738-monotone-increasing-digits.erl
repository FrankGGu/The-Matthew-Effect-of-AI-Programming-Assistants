-module(solution).
-export([monotoneIncreasingDigits/1]).

monotoneIncreasingDigits(N) ->
    Digits = integer_to_list(N),
    NewDigits = make_monotone(Digits, []),
    list_to_integer(NewDigits).

make_monotone([], Acc) -> lists:reverse(Acc);
make_monotone([H | T], Acc) ->
    case T of
        [] -> make_monotone([], [H | Acc]);
        [H2 | _] when H > H2 -> 
            make_monotone([], [H - 1 | Acc]);
        _ -> make_monotone(T, [H | Acc])
    end.