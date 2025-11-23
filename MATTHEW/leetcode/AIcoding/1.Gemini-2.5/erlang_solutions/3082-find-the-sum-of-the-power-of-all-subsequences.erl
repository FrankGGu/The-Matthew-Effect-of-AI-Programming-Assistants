-module(solution).
-export([sum_of_power/1]).

sum_of_power(Nums) ->
    P = 1000000007,
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    PowersOf2 = precompute_powers(N, P),
    calculate_sum(SortedNums, N, P, PowersOf2, 0, 0).

calculate_sum([], _N, _P, _PowersOf2, _K, Acc) ->
    Acc;
calculate_sum([Val|Rest], N, P, PowersOf2, K, Acc) ->
    ValSq = (Val * Val) rem P,

    % Get 2^(N-1-K)
    % PowersOf2 is 0-indexed: PowersOf2[Idx] = 2^Idx
    % lists:nth is 1-indexed, so we need Idx + 1
    Pow1 = lists:nth(N - 1 - K + 1, PowersOf2), 

    % Get 2^K
    Pow2 = lists:nth(K + 1, PowersOf2),

    SumOfPowers = (Pow1 + Pow2) rem P,
    Term = (ValSq * SumOfPowers) rem P,

    NewAcc = (Acc + Term) rem P,
    calculate_sum(Rest, N, P, PowersOf2, K + 1, NewAcc).

precompute_powers(N, P) ->
    precompute_powers_recursive(N, P, 0, 1, []).

precompute_powers_recursive(N, _P, N, _CurrentPower, Acc) ->
    lists:reverse(Acc);
precompute_powers_recursive(N, P, K, CurrentPower, Acc) ->
    precompute_powers_recursive(N, P, K + 1, (CurrentPower * 2) rem P, [CurrentPower | Acc]).