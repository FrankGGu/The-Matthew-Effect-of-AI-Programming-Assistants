-module(ways_to_express).
-export([number_of_ways/2]).

number_of_ways(n, x) ->
    number_of_ways(n, x, 1).

number_of_ways(0, _, _) -> 1;
number_of_ways(N, X, I) when N < 0 -> 0;
number_of_ways(N, X, I) ->
    Pow = math:pow(I, X),
    if
        Pow > N ->
            0;
        true ->
            number_of_ways(N, X, I + 1) + number_of_ways(N - trunc(Pow), X, I + 1)
    end.