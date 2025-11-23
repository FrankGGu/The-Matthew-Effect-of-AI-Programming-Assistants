-module(solution).
-export([diagonal_prime/1]).

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) -> is_prime_check(N, 3).

is_prime_check(N, I) when I * I > N -> true;
is_prime_check(N, I) when N rem I == 0 -> false;
is_prime_check(N, I) -> is_prime_check(N, I + 2).

diagonal_prime(Matrix) ->
    N = length(Matrix),
    Indices = lists:seq(0, N - 1),
    lists:foldl(fun(Index, AccMaxPrime) ->
                        Row = lists:nth(Index + 1, Matrix),

                        MainDiagElement = lists:nth(Index + 1, Row),
                        NewMaxPrime1 = update_max_prime(MainDiagElement, AccMaxPrime),

                        AntiDiagElement = lists:nth(N - Index, Row),
                        update_max_prime(AntiDiagElement, NewMaxPrime1)
                end, 0, Indices).

update_max_prime(Num, CurrentMaxPrime) ->
    if is_prime(Num) andalso Num > CurrentMaxPrime -> Num;
       true -> CurrentMaxPrime
    end.