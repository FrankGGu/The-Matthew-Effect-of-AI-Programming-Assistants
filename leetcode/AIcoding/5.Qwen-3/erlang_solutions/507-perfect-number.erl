-module(perfect_number).
-export([is_perfect/1]).

is_perfect(N) ->
    case N of
        1 -> false;
        _ ->
            Sum = sum_of_divisors(N),
            Sum == N
    end.

sum_of_divisors(N) ->
    sum_of_divisors(N, 2, 1).

sum_of_divisors(N, I, Acc) ->
    if
        I * I > N ->
            Acc;
        true ->
            case N rem I of
                0 ->
                    if
                        I * I == N ->
                            sum_of_divisors(N, I + 1, Acc + I);
                        true ->
                            sum_of_divisors(N, I + 1, Acc + I + N div I)
                    end;
                _ ->
                    sum_of_divisors(N, I + 1, Acc)
            end
    end.