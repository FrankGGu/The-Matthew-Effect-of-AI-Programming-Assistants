-spec is_perfect_square(Num :: integer()) -> boolean().
is_perfect_square(Num) ->
    is_perfect_square(Num, 1).

is_perfect_square(Num, Guess) when Guess * Guess =:= Num -> true;
is_perfect_square(Num, Guess) when Guess * Guess > Num -> false;
is_perfect_square(Num, Guess) -> is_perfect_square(Num, Guess + 1).
