-module(solution).
-export([is_happy/1]).

is_happy(N) ->
    is_happy(N, sets:new()).

is_happy(1, _) ->
    true;
is_happy(N, Seen) ->
    case sets:is_element(N, Seen) of
        true -> false;
        false ->
            NewSeen = sets:add_element(N, Seen),
            Next = sum_squares(N),
            is_happy(Next, NewSeen)
    end.

sum_squares(0) -> 0;
sum_squares(N) ->
    Digit = N rem 10,
    Digit * Digit + sum_squares(N div 10).