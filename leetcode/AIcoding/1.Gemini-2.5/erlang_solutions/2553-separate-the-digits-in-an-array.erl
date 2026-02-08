-spec separate_digits(Nums :: [integer()]) -> [integer()].
separate_digits(Nums) ->
    lists:flatmap(fun(N) -> [C - $0 || C <- integer_to_list(N)] end, Nums).