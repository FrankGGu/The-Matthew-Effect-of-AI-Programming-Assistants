-module(nth_magical_number).
-export([nth_magical_number/3]).

lcm(A, B) ->
    A * B div gcd(A, B).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

nth_magical_number(N, A, B) ->
    Lcm = lcm(A, B),
    Low = 0,
    High = 10 ** 14,
    while Low < High do
        Mid = Low + (High - Low) div 2,
        Count = Mid div A + Mid div B - Mid div Lcm,
        if Count < N then
            Low = Mid + 1
        else
            High = Mid
        end
    end,
    Low rem (10 ** 9 + 7).