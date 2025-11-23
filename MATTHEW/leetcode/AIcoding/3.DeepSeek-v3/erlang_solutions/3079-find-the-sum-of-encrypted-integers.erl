-spec encrypt_num(N :: integer()) -> integer().
encrypt_num(N) ->
    Digits = [D - $0 || D <- integer_to_list(N)],
    Max = lists:max(Digits),
    Encrypted = lists:duplicate(length(Digits), Max),
    list_to_integer([D + $0 || D <- Encrypted]).

-spec sum_of_encrypted_int(Nums :: [integer()]) -> integer().
sum_of_encrypted_int(Nums) ->
    lists:sum([encrypt_num(N) || N <- Nums]).