-spec sum_of_multiples(N :: integer()) -> integer().
sum_of_multiples(N) ->
    lists:sum([X || X <- lists:seq(1, N), (X rem 3 =:= 0) or (X rem 5 =:= 0) or (X rem 7 =:= 0)]).