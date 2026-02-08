-module(solution).
-export([self_dividing_numbers/2]).

is_self_dividing(OriginalN, 0) ->
    true;
is_self_dividing(OriginalN, CurrentN) ->
    Digit = CurrentN rem 10,
    if
        Digit == 0 -> false;
        OriginalN rem Digit == 0 -> is_self_dividing(OriginalN, CurrentN div 10);
        true -> false
    end.

self_dividing_numbers(Left, Right) ->
    [N || N <- lists:seq(Left, Right), is_self_dividing(N, N)].