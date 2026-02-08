-spec diagonal_prime(Nums :: [[integer()]]) -> integer().
diagonal_prime(Nums) ->
    N = length(Nums),
    Diagonal = lists:foldl(
        fun(I, Acc) ->
            case I =:= N - I - 1 of
                true -> [lists:nth(I + 1, lists:nth(I + 1, Nums)) | Acc];
                false -> [lists:nth(I + 1, lists:nth(I + 1, Nums)), lists:nth(I + 1, lists:nth(N - I, Nums)) | Acc]
            end
        end,
        [],
        lists:seq(0, N - 1)
    ),
    Primes = lists:filter(fun is_prime/1, Diagonal),
    case Primes of
        [] -> 0;
        _ -> lists:max(Primes)
    end.

is_prime(1) -> false;
is_prime(2) -> true;
is_prime(N) when N < 2 -> false;
is_prime(N) ->
    Max = trunc(math:sqrt(N)) + 1,
    is_prime_helper(N, 2, Max).

is_prime_helper(N, I, Max) when I >= Max -> true;
is_prime_helper(N, I, Max) ->
    case N rem I =:= 0 of
        true -> false;
        false -> is_prime_helper(N, I + 1, Max)
    end.