-module(prime_in_diagonal).
-export([is_prime/1, solve/1]).

is_prime(1) -> false;
is_prime(2) -> true;
is_prime(N) when N rem 2 == 0 -> false;
is_prime(N) -> is_prime(N, 3).

is_prime(N, I) when I * I > N -> true;
is_prime(N, I) when N rem I == 0 -> false;
is_prime(N, I) -> is_prime(N, I + 2).

solve(Matrix) ->
    Rows = length(Matrix),
    Count = lists:foldl(fun(I, Acc) ->
        Row = lists:nth(I + 1, Matrix),
        Element = lists:nth(I + 1, Row),
        case is_prime(Element) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, lists:seq(0, Rows - 1)),
    Count.