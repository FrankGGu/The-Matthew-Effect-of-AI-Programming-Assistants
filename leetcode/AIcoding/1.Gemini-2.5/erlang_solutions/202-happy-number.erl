-module(solution).
-export([is_happy/1]).

sum_of_squares_of_digits(N) ->
    sum_of_squares_of_digits(N, 0).

sum_of_squares_of_digits(0, Acc) -> Acc;
sum_of_squares_of_digits(N, Acc) ->
    Digit = N rem 10,
    NextN = N div 10,
    sum_of_squares_of_digits(NextN, Acc + Digit*Digit).

is_happy(N) when N =< 0 -> false;
is_happy(N) ->
    is_happy_recursive(N, sets:new()).

is_happy_recursive(1, _Seen) -> true;
is_happy_recursive(N, Seen) ->
    case sets:is_element(N, Seen) of
        true -> false;
        false ->
            NewSeen = sets:add_element(N, Seen),
            NextN = sum_of_squares_of_digits(N),
            is_happy_recursive(NextN, NewSeen)
    end.