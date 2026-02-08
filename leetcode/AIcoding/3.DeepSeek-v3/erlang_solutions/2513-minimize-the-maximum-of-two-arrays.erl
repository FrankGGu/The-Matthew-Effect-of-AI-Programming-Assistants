-module(solution).
-export([minimize_set/2]).

minimize_set(Divisor1, Divisor2) ->
    LCM = lcm(Divisor1, Divisor2),
    Low = 1,
    High = 2 * (Divisor1 + Divisor2),
    BinarySearch = fun BinarySearch(L, R) ->
        if
            L >= R -> L;
            true ->
                Mid = (L + R) div 2,
                Count = Mid - Mid div Divisor1 - Mid div Divisor2 + Mid div LCM,
                if
                    Count >= Divisor1 + Divisor2 -> BinarySearch(L, Mid);
                    true -> BinarySearch(Mid + 1, R)
                end
        end
    end,
    BinarySearch(Low, High).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A * B) div gcd(A, B).