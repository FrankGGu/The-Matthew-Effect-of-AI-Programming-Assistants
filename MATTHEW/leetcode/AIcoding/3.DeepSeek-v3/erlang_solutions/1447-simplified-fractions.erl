-spec simplified_fractions(N :: integer()) -> [unicode:unicode_binary()].
simplified_fractions(N) ->
    lists:sort(
        lists:flatmap(
            fun(Denominator) ->
                lists:flatmap(
                    fun(Numerator) ->
                        case gcd(Numerator, Denominator) of
                            1 -> [io_lib:format("~B/~B", [Numerator, Denominator])];
                            _ -> []
                        end
                    end,
                    lists:seq(1, Denominator - 1)
            end,
            lists:seq(2, N))
    ).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).