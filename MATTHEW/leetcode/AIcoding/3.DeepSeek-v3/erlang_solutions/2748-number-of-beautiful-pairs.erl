-spec count_beautiful_pairs(Nums :: [integer()]) -> integer().
count_beautiful_pairs(Nums) ->
    count_beautiful_pairs(Nums, 0, 0).

count_beautiful_pairs([], _I, Count) ->
    Count;
count_beautiful_pairs([X | Rest], I, Count) ->
    FirstDigit = first_digit(X),
    NewCount = lists:foldl(
        fun(Y, Acc) ->
            LastDigit = Y rem 10,
            case gcd(FirstDigit, LastDigit) of
                1 -> Acc + 1;
                _ -> Acc
            end
        end,
        Count,
        Rest
    ),
    count_beautiful_pairs(Rest, I + 1, NewCount).

first_digit(X) ->
    first_digit(abs(X), 0).

first_digit(0, Acc) ->
    Acc;
first_digit(X, _Acc) ->
    first_digit(X div 10, X rem 10).

gcd(A, 0) ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).