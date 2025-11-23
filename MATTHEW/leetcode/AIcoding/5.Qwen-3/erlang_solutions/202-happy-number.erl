-module(happy_number).
-export([is_happy/1]).

is_happy(N) ->
    is_happy(N, sets:new()).

is_happy(1, _) ->
    true;
is_happy(N, Seen) when N < 1 ->
    false;
is_happy(N, Seen) ->
    case sets:is_element(N, Seen) of
        true ->
            false;
        false ->
            NewSeen = sets:add_element(N, Seen),
            Sum = sum_of_squares(N),
            is_happy(Sum, NewSeen)
    end.

sum_of_squares(N) ->
    sum_of_squares(N, 0).

sum_of_squares(0, Acc) ->
    Acc;
sum_of_squares(N, Acc) ->
    Digit = N rem 10,
    sum_of_squares(N div 10, Acc + Digit * Digit).