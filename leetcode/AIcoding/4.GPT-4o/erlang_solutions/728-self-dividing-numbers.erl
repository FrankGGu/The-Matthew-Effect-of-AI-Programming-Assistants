-module(solution).
-export([self_dividing_numbers/2]).

self_dividing_numbers(Low, High) ->
    lists:filter(fun(N) -> is_self_dividing(N) end, lists:seq(Low, High)).

is_self_dividing(N) ->
    is_self_dividing(N, N).

is_self_dividing(0, _) -> false;
is_self_dividing(N, Original) ->
    Digit = N rem 10,
    case Digit of
        0 -> false;
        _ -> if
            Original rem Digit =:= 0 -> is_self_dividing(N div 10, Original);
            true -> false
        end
    end.