-spec my_pow(X :: float(), N :: integer()) -> float().
my_pow(X, N) when N == 0 -> 1.0;
my_pow(X, N) when N < 0 -> 1 / my_pow(X, -N);
my_pow(X, N) ->
    case N rem 2 of
        0 -> 
            Result = my_pow(X, N div 2),
            Result * Result;
        _ -> 
            Result = my_pow(X, (N - 1) div 2),
            X * Result * Result
    end.
