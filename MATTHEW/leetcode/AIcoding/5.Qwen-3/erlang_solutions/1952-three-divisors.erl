-module(three_divisors).
-export([is_three_divisors/1]).

is_three_divisors(N) ->
    is_three_divisors(N, 2, 0).

is_three_divisors(N, I, Count) when I * I > N ->
    Count == 2;
is_three_divisors(N, I, Count) ->
    case N rem I of
        0 ->
            case I * I == N of
                true -> is_three_divisors(N, I + 1, Count + 1);
                false -> is_three_divisors(N, I + 1, Count + 2)
            end;
        _ ->
            is_three_divisors(N, I + 1, Count)
    end.