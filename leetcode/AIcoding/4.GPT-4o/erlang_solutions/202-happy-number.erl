-spec is_happy(N :: integer()) -> boolean().
is_happy(N) ->
    is_happy(N, []).

is_happy(1, _) -> true;
is_happy(N, Seen) when N > 1 ->
    Next = sum_of_squares(N),
    case lists:member(Next, Seen) of
        true -> false;
        false -> is_happy(Next, [Next | Seen])
    end.

sum_of_squares(N) ->
    N
    |> integer_to_list()
    |> lists:map(fun(C) -> (list_to_integer([C]) - 48) * (list_to_integer([C]) - 48) end)
    |> lists:sum().
