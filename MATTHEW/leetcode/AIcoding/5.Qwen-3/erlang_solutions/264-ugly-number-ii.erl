-module(ugly).
-export([nth_ugly_number/1]).

nth_ugly_number(N) ->
    lists:nth(N, generate_ugly(1, 1, 1, 1, [1])).

generate_ugly(_, _, _, _, Acc) when length(Acc) >= 1000 ->
    Acc;
generate_ugly(I2, I3, I5, Next, Acc) ->
    Ugly2 = lists:nth(I2, Acc) * 2,
    Ugly3 = lists:nth(I3, Acc) * 3,
    Ugly5 = lists:nth(I5, Acc) * 5,
    Next = lists:minimum([Ugly2, Ugly3, Ugly5]),
    case Next of
        Ugly2 ->
            generate_ugly(I2 + 1, I3, I5, Next, Acc ++ [Next]);
        Ugly3 ->
            generate_ugly(I2, I3 + 1, I5, Next, Acc ++ [Next]);
        Ugly5 ->
            generate_ugly(I2, I3, I5 + 1, Next, Acc ++ [Next])
    end.