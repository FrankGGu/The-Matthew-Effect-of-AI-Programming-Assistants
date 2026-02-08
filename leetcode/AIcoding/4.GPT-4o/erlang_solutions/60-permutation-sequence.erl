-spec get_permutation(N :: integer(), K :: integer()) -> unicode:unicode_binary().
get_permutation(N, K) ->
    List = lists:seq(1, N),
    Factorial = factorial(N - 1),
    get_permutation(List, K - 1, Factorial, []).

get_permutation([], _, _, Acc) -> lists:reverse(Acc);
get_permutation(List, K, Factorial, Acc) ->
    {Quotient, Remainder} = divmod(K, Factorial),
    {Chosen, Rest} = lists:split(Quotient, List),
    get_permutation(Rest, Remainder, Factorial div length(List), [Chosen | Acc]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).

divmod(A, B) -> {A div B, A rem B}.
