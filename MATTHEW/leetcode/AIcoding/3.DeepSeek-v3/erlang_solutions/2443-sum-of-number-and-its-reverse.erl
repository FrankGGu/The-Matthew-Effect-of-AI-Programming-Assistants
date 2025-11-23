-spec sum_of_number_and_reverse(Num :: integer()) -> boolean().
sum_of_number_and_reverse(Num) ->
    lists:any(fun(K) -> K + reverse(K) =:= Num end, lists:seq(0, Num)).

reverse(N) ->
    list_to_integer(lists:reverse(integer_to_list(N))).