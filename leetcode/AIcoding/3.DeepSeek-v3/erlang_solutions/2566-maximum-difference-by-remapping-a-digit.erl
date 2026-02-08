-spec min_max_difference(Num :: integer()) -> integer().
min_max_difference(Num) ->
    S = integer_to_list(Num),
    {Max, _} = find_max(S),
    {Min, _} = find_min(S),
    Max - Min.

find_max(S) ->
    case find_first_non_nine(S) of
        none -> {list_to_integer(S), none};
        X -> {list_to_integer(replace_all(S, X, $9)), X}
    end.

find_min(S) ->
    case find_first_non_zero(S) of
        none -> {list_to_integer(S), none};
        X -> {list_to_integer(replace_all(S, X, $0)), X}
    end.

find_first_non_nine([]) -> none;
find_first_non_nine([H|T]) ->
    case H =/= $9 of
        true -> H;
        false -> find_first_non_nine(T)
    end.

find_first_non_zero([]) -> none;
find_first_non_zero([H|T]) ->
    case H =/= $0 of
        true -> H;
        false -> find_first_non_zero(T)
    end.

replace_all([], _, _) -> [];
replace_all([H|T], X, Y) ->
    case H =:= X of
        true -> [Y | replace_all(T, X, Y)];
        false -> [H | replace_all(T, X, Y)]
    end.