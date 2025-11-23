-spec is_perfect_square(Num :: integer()) -> boolean().
is_perfect_square(Num) ->
    is_perfect_square(Num, 0, Num).

is_perfect_square(Num, Low, High) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    Square = Mid * Mid,
    if
        Square =:= Num -> true;
        Square < Num -> is_perfect_square(Num, Mid + 1, High);
        true -> is_perfect_square(Num, Low, Mid - 1)
    end;
is_perfect_square(_, _, _) -> false.