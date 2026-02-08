-module(minimize_maximum_two_arrays).
-export([minimize_maximum/5]).

minimize_maximum(Divisor1, Divisor2, UniqueCnt1, UniqueCnt2, N) ->
    minimize_maximum_helper(1, N, Divisor1, Divisor2, UniqueCnt1, UniqueCnt2, N).

minimize_maximum_helper(Low, High, Divisor1, Divisor2, UniqueCnt1, UniqueCnt2, N) ->
    if Low > High ->
        High + 1;
    true ->
        Mid = Low + (High - Low) div 2,
        if is_valid(Mid, Divisor1, Divisor2, UniqueCnt1, UniqueCnt2, N) ->
            minimize_maximum_helper(Low, Mid - 1, Divisor1, Divisor2, UniqueCnt1, UniqueCnt2, N);
        true ->
            minimize_maximum_helper(Mid + 1, High, Divisor1, Divisor2, UniqueCnt1, UniqueCnt2, N)
    end.

is_valid(Mid, Divisor1, Divisor2, UniqueCnt1, UniqueCnt2, N) ->
    NotDiv1 = Mid - Mid div Divisor1,
    NotDiv2 = Mid - Mid div Divisor2,
    NotDivBoth = Mid - Mid div Divisor1 - Mid div Divisor2 + Mid div lcm(Divisor1, Divisor2),
    NotDiv1 >= UniqueCnt1 andalso NotDiv2 >= UniqueCnt2 andalso NotDivBoth >= UniqueCnt1 + UniqueCnt2.

lcm(A, B) ->
    A * B div gcd(A, B).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).