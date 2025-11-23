-module(solution).
-export([number_of_sequences/2]).

number_of_sequences(N, Sick) ->
    SickList = lists:sort(Sick),
    Gaps = calculate_gaps(N, SickList),
    Fact = factorial(N - length(SickList)),
    GapProduct = lists:foldl(fun(G, Acc) -> (Acc * factorial(G)) rem 1000000007 end, 1, Gaps),
    Total = (Fact * modinv(GapProduct, 1000000007)) rem 1000000007,
    Total.

calculate_gaps(N, [H|T]) ->
    calculate_gaps(1, N, [H|T], []).

calculate_gaps(Prev, N, [H|T], Acc) ->
    Gap = H - Prev,
    calculate_gaps(H + 1, N, T, [Gap | Acc]);
calculate_gaps(Prev, N, [], Acc) ->
    Gap = N - Prev + 1,
    lists:reverse([Gap | Acc]).

factorial(0) -> 1;
factorial(N) -> (N * factorial(N - 1)) rem 1000000007.

modinv(A, M) ->
    {G, X, _} = extended_gcd(A, M),
    if
        G =:= 1 -> (X rem M + M) rem M;
        true -> 0
    end.

extended_gcd(A, 0) -> {A, 1, 0};
extended_gcd(A, B) ->
    {G, X, Y} = extended_gcd(B, A rem B),
    {G, Y, X - (A div B) * Y}.