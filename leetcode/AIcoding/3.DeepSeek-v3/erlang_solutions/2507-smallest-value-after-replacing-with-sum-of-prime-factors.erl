-spec smallest_value(N :: integer()) -> integer().
smallest_value(N) ->
    case is_prime(N) of
        true -> N;
        false ->
            Sum = sum_prime_factors(N),
            if
                Sum == N -> N;
                true -> smallest_value(Sum)
            end
    end.

sum_prime_factors(N) ->
    sum_prime_factors(N, 2, 0).

sum_prime_factors(1, _, Sum) -> Sum;
sum_prime_factors(N, P, Sum) when P * P > N ->
    if
        N > 1 -> Sum + N;
        true -> Sum
    end;
sum_prime_factors(N, P, Sum) ->
    case N rem P == 0 of
        true -> sum_prime_factors(N div P, P, Sum + P);
        false -> sum_prime_factors(N, P + 1, Sum)
    end.

is_prime(1) -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) ->
    is_prime(N, 3).

is_prime(N, P) when P * P > N -> true;
is_prime(N, P) ->
    case N rem P == 0 of
        true -> false;
        false -> is_prime(N, P + 2)
    end.