-module(solution).
-export([sum_four_divisors/1]).

sum_four_divisors(N) ->
    lists:sum([X || X <- lists:seq(1, N), four_divisors(X)]).

four_divisors(X) ->
    Divisors = [D || D <- lists:seq(1, trunc(math:sqrt(X))), X rem D =:= 0],
    Divisors1 = lists:flatmap(fun(D) -> [D, div(X, D)] end, Divisors),
    case lists:usort(Divisors1) of
        Divisors2 when length(Divisors2) =:= 4 -> lists:sum(Divisors2);
        _ -> 0
    end.