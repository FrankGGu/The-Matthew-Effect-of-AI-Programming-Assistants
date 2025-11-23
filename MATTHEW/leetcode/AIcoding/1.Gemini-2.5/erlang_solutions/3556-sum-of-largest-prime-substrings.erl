-module(solution).
-export([solve/1]).

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) ->
    check_prime(N, 3).

check_prime(N, Divisor) when Divisor * Divisor > N -> true;
check_prime(N, Divisor) when N rem Divisor == 0 -> false;
check_prime(N, Divisor) ->
    check_prime(N, Divisor + 2).

solve(S) ->
    Len = length(S),
    lists:foldl(fun(I, AccSum) ->
        MaxPrimeForI = find_max_prime_starting_at(S, I, Len),
        AccSum + MaxPrimeForI
    end, 0, lists:seq(1, Len)).

find_max_prime_starting_at(S, StartIdx, Len) ->
    lists:foldl(fun(EndIdx, AccMaxPrime) ->
        SubstrLen = EndIdx - StartIdx + 1,
        Substr = string:substr(S, StartIdx, SubstrLen),
        Num = list_to_integer(Substr),

        case is_prime(Num) of
            true -> max(AccMaxPrime, Num);
            false -> AccMaxPrime
        end
    end, 0, lists:seq(StartIdx, Len)).