-spec kth_smallest_prime_fraction(Arr :: [integer()], K :: integer()) -> [integer()].
kth_smallest_prime_fraction(Arr, K) ->
    N = length(Arr),
    Fs = lists:sort([{lists:nth(I, Arr) / lists:nth(J, Arr), I-1, J-1} || I <- lists:seq(1, N), J <- lists:seq(I+1, N)]),
    {_, A, B} = lists:nth(K, Fs),
    [lists:nth(A+1, Arr), lists:nth(B+1, Arr)].