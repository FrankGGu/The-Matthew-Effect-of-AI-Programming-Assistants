-spec max_score(Nums :: [integer()]) -> integer().
max_score(Nums) ->
    PrimeFactors = lists:foldl(
        fun(Num, Acc) ->
            Factors = prime_factors(Num),
            maps:merge_with(fun(_, V1, V2) -> V1 + V2 end, Acc, Factors)
        end,
        #{},
        Nums
    ),
    maps:fold(
        fun(_, V, Acc) -> Acc + V end,
        0,
        PrimeFactors
    ).

prime_factors(N) ->
    prime_factors(N, 2, #{}).

prime_factors(1, _, Factors) -> Factors;
prime_factors(N, P, Factors) when P * P > N ->
    if
        N > 1 -> maps:put(N, maps:get(N, Factors, 0) + 1, Factors);
        true -> Factors
    end;
prime_factors(N, P, Factors) when N rem P =:= 0 ->
    prime_factors(N div P, P, maps:put(P, maps:get(P, Factors, 0) + 1, Factors));
prime_factors(N, P, Factors) ->
    prime_factors(N, P + 1, Factors).