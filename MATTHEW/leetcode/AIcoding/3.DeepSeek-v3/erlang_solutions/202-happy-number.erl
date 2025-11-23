-spec is_happy(N :: integer()) -> boolean().
is_happy(N) ->
    Seen = sets:new(),
    is_happy_helper(N, Seen).

is_happy_helper(1, _Seen) ->
    true;
is_happy_helper(N, Seen) ->
    case sets:is_element(N, Seen) of
        true -> false;
        false ->
            NewSeen = sets:add_element(N, Seen),
            Next = sum_of_squares(N),
            is_happy_helper(Next, NewSeen)
    end.

sum_of_squares(0) -> 0;
sum_of_squares(N) ->
    Digit = N rem 10,
    Digit * Digit + sum_of_squares(N div 10).