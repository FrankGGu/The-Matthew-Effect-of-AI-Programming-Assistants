-module(solution).
-export([largest_palindrome/1]).

power(Base, Exp) ->
    power(Base, Exp, 1).

power(_, 0, Acc) -> Acc;
power(Base, Exp, Acc) ->
    power(Base, Exp - 1, Acc * Base).

reverse(N) ->
    reverse(N, 0).

reverse(0, Acc) -> Acc;
reverse(N, Acc) ->
    reverse(N div 10, Acc * 10 + (N rem 10)).

make_palindrome(Half, N) ->
    RevHalf = reverse(Half),
    Half * power(10, N) + RevHalf.

largest_palindrome(N) ->
    if N == 1 -> 9;
       true ->
            Upper = power(10, N) - 1,
            Lower = power(10, N - 1),

            largest_palindrome_search(Upper, Lower, Upper, N)
    end.

largest_palindrome_search(I, LowerBound, UpperBound, N) ->
    if I < LowerBound ->
        0;
       true ->
            P = make_palindrome(I, N),
            case check_factors_loop(P, UpperBound, LowerBound, UpperBound) of
                found -> P rem 1337;
                not_found -> largest_palindrome_search(I - 1, LowerBound, UpperBound, N)
            end
    end.

check_factors_loop(P, J, MinFactor, MaxFactor) ->
    if J < MinFactor -> not_found;
       J * J < P -> not_found;
       true ->
            if P rem J == 0 ->
                K = P div J,
                if K >= MinFactor andalso K <= MaxFactor -> found;
                   true -> check_factors_loop(P, J - 1, MinFactor, MaxFactor)
                end;
            true -> check_factors_loop(P, J - 1, MinFactor, MaxFactor)
            end
    end.