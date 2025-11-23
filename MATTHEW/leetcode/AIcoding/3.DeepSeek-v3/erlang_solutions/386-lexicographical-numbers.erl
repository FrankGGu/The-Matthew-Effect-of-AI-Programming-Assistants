-spec lexical_order(N :: integer()) -> [integer()].
lexical_order(N) ->
    lists:sort(fun(A, B) -> integer_to_list(A) < integer_to_list(B) end, lists:seq(1, N)).