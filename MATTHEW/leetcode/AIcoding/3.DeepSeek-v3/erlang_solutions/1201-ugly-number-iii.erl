-module(solution).
-export([nth_ugly_number/4]).

nth_ugly_number(N, A, B, C) ->
    Low = 1,
    High = 2000000000,
    binary_search(N, A, B, C, Low, High).

binary_search(N, A, B, C, Low, High) ->
    if
        Low >= High -> Low;
        true ->
            Mid = (Low + High) div 2,
            Count = count_ugly(Mid, A, B, C),
            if
                Count < N -> binary_search(N, A, B, C, Mid + 1, High);
                true -> binary_search(N, A, B, C, Low, Mid)
            end
    end.

count_ugly(N, A, B, C) ->
    AB = lcm(A, B),
    AC = lcm(A, C),
    BC = lcm(B, C),
    ABC = lcm(A, BC),
    (N div A) + (N div B) + (N div C) - (N div AB) - (N div AC) - (N div BC) + (N div ABC).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A * B) div gcd(A, B).