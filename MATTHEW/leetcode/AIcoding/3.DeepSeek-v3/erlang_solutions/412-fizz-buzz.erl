-spec fizz_buzz(N :: integer()) -> [unicode:unicode_binary()].
fizz_buzz(N) ->
    lists:map(fun
        (X) when X rem 15 == 0 -> <<"FizzBuzz">>;
        (X) when X rem 3 == 0 -> <<"Fizz">>;
        (X) when X rem 5 == 0 -> <<"Buzz">>;
        (X) -> integer_to_binary(X)
    end, lists:seq(1, N)).