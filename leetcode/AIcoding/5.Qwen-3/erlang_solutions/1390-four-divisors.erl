-module(four_divisors).
-export([four_divisors/1]).

four_divisors(N) ->
    four_divisors(N, 1, 0, 0).

four_divisors(N, I, Count, Sum) when I > N ->
    if
        Count == 4 -> Sum;
        true -> 0
    end;

four_divisors(N, I, Count, Sum) ->
    case N rem I of
        0 ->
            case N div I of
                I -> four_divisors(N, I + 1, Count + 1, Sum + I);
                _ -> four_divisors(N, I + 1, Count + 2, Sum + I + (N div I))
            end;
        _ -> four_divisors(N, I + 1, Count, Sum)
    end.