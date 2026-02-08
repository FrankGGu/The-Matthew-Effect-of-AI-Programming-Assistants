-module(self_dividing_numbers).
-export([self_dividing_numbers/2]).

self_dividing_numbers(Left, Right) ->
    lists:filter(fun(N) -> is_self_dividing(N) end, lists:seq(Left, Right)).

is_self_dividing(N) ->
    is_self_dividing(N, N).

is_self_dividing(0, _) ->
    true;
is_self_dividing(N, Original) ->
    Digit = N rem 10,
    if
        Digit == 0 -> false;
        (Original rem Digit) /= 0 -> false;
        true -> is_self_dividing(N div 10, Original)
    end.