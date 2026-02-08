-module(solution).
-export([smallest_value/1]).

smallest_value(N) ->
    smallest_value_loop(N).

smallest_value_loop(N) ->
    NextN = prime_factors_sum(N),
    if
        NextN == N -> N;
        true -> smallest_value_loop(NextN)
    end.

prime_factors_sum(N) ->
    prime_factors_sum(N, 2, 0).

prime_factors_sum(1, _, Sum) -> Sum;
prime_factors_sum(N, D, Sum) when D * D > N -> Sum + N;
prime_factors_sum(N, D, Sum) ->
    case N rem D of
        0 ->
            prime_factors_sum(N div D, D, Sum + D);
        _ ->
            prime_factors_sum(N, D + 1, Sum)
    end.