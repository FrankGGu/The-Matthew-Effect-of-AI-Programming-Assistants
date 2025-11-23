-spec add_digits(Num :: integer()) -> integer().
add_digits(Num) when Num == 0 -> 0;
add_digits(Num) -> 
    case Num rem 9 of
        0 -> 9;
        R -> R
    end.
