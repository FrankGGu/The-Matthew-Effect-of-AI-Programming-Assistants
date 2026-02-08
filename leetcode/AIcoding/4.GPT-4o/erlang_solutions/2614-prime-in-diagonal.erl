-module(solution).
-export([diagonalPrime/1]).

diagonalPrime(Matrix) ->
    N = length(Matrix),
    DiagonalPrimes = [Element || {Row, Col, Element} <- lists:foldl(
        fun(Row, Acc) ->
            Col = lists:nth(Row + 1, Matrix),
            case lists:nth(Row + 1, Col) of
                E when is_prime(E) -> [{Row, Row, E} | Acc];
                _ -> Acc
            end
        end,
        [],
        lists:seq(0, N - 1)
    )],
    case DiagonalPrimes of
        [] -> 0;
        _ -> lists:max(DiagonalPrimes)
    end.

is_prime(N) when N < 2 -> false;
is_prime(2) -> true;
is_prime(N) -> 
    lists:all(fun(X) -> N rem X =/= 0 end, lists:seq(2, trunc(math:sqrt(N)))).