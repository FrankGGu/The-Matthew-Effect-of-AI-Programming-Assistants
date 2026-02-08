-spec common_factors(A :: integer(), B :: integer()) -> integer().
common_factors(A, B) ->
    Gcd = gcd(A, B),
    count_factors(Gcd).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

count_factors(N) ->
    count_factors(N, 1, 0).

count_factors(N, I, Count) when I * I > N ->
    Count;
count_factors(N, I, Count) when N rem I =:= 0 ->
    if
        I * I =:= N -> count_factors(N, I + 1, Count + 1);
        true -> count_factors(N, I + 1, Count + 2)
    end;
count_factors(N, I, Count) ->
    count_factors(N, I + 1, Count).