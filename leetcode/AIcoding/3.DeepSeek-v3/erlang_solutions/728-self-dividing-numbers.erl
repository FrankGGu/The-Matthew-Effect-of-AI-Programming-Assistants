-spec self_dividing_numbers(Left :: integer(), Right :: integer()) -> [integer()].
self_dividing_numbers(Left, Right) ->
    lists:filter(fun(X) -> is_self_dividing(X) end, lists:seq(Left, Right)).

is_self_dividing(N) ->
    Digits = [C - $0 || C <- integer_to_list(N)],
    lists:all(fun(D) -> D =/= 0 andalso N rem D =:= 0 end, Digits).