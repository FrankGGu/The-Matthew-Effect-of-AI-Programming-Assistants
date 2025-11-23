-spec separate_digits(Nums :: [integer()]) -> [integer()].
separate_digits(Nums) ->
    lists:flatten([digits(X) || X <- Nums]).

digits(N) when N < 10 ->
    [N];
digits(N) ->
    digits(N div 10) ++ [N rem 10].