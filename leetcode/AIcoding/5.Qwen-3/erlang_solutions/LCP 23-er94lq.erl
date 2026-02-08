-module(magic_permutation).
-export([numPermutations/1]).

numPermutations(N) ->
    numPermutations(N, 1, 1, 0).

numPermutations(_, _, _, Acc) when Acc == 1 -> 1;
numPermutations(N, K, I, Acc) when I > N -> Acc;
numPermutations(N, K, I, Acc) ->
    case is_prime(I) of
        true ->
            NewAcc = if
                (K rem I) == 0 -> Acc + 1;
                true -> Acc
            end,
            numPermutations(N, K + 1, I + 1, NewAcc);
        false ->
            numPermutations(N, K, I + 1, Acc)
    end.

is_prime(1) -> false;
is_prime(2) -> true;
is_prime(P) ->
    is_prime(P, 2).

is_prime(P, D) when D * D > P -> true;
is_prime(P, D) ->
    case P rem D of
        0 -> false;
        _ -> is_prime(P, D + 1)
    end.