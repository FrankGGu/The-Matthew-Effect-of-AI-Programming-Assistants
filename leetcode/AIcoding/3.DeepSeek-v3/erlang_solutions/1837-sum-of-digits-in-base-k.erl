-spec sum_base(N :: integer(), K :: integer()) -> integer().
sum_base(N, K) ->
    sum_digits(convert_to_base(N, K)).

convert_to_base(0, _) -> [];
convert_to_base(N, K) when N > 0 ->
    [N rem K | convert_to_base(N div K, K)].

sum_digits(Digits) ->
    lists:sum(Digits).