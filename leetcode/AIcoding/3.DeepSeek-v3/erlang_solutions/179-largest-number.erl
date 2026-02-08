-spec largest_number(Nums :: [integer()]) -> unicode:unicode_binary().
largest_number(Nums) ->
    Strs = lists:map(fun(N) -> integer_to_binary(N) end, Nums),
    Sorted = lists:sort(fun(A, B) -> binary_to_list(<<A/binary, B/binary>>) > binary_to_list(<<B/binary, A/binary>>) end, Strs),
    case lists:all(fun(S) -> S == <<"0">> end, Sorted) of
        true -> <<"0">>;
        false -> list_to_binary(Sorted)
    end.