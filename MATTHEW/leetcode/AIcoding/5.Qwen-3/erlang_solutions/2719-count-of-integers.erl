-module(solution).
-export([count_integers/2]).

count_integers(Start, End) ->
    count_integers(Start, End, 0).

count_integers(N, End, Acc) when N > End ->
    Acc;
count_integers(N, End, Acc) ->
    case is_valid(N) of
        true -> count_integers(N + 1, End, Acc + 1);
        false -> count_integers(N + 1, End, Acc)
    end.

is_valid(N) ->
    is_valid(N, []).

is_valid(0, _) ->
    true;
is_valid(N, Digits) ->
    Digit = N rem 10,
    if
        lists:member(Digit, Digits) -> false;
        true -> is_valid(N div 10, [Digit | Digits])
    end.