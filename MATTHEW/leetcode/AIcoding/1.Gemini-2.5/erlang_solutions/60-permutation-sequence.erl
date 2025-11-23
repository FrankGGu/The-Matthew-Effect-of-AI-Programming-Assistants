-module(solution).
-export([getPermutation/2]).

getPermutation(N, K) ->
    K0 = K - 1,

    Numbers = lists:seq(1, N),

    Factorials = precompute_factorials(N),

    generate_permutation(N, K0, Numbers, Factorials, []).

precompute_factorials(N) ->
    lists:reverse(precompute_factorials_acc(N, [1], 1)).

precompute_factorials_acc(N, Acc, Current) when Current =< N ->
    NextFact = lists:hd(Acc) * Current,
    precompute_factorials_acc(N, [NextFact | Acc], Current + 1);
precompute_factorials_acc(_, Acc, _) ->
    Acc.

generate_permutation(0, _, _, _, Acc) ->
    lists:flatten(lists:reverse(Acc));
generate_permutation(N_remaining, K_remaining, AvailableNumbers, Factorials, Acc) ->
    BlockSize = lists:nth(N_remaining, Factorials),

    DigitIndex = K_remaining div BlockSize,

    Digit = lists:nth(DigitIndex + 1, AvailableNumbers),

    NewAvailableNumbers = lists:delete(Digit, AvailableNumbers),

    NewK_remaining = K_remaining rem BlockSize,

    generate_permutation(N_remaining - 1, NewK_remaining, NewAvailableNumbers, Factorials, [integer_to_list(Digit) | Acc]).