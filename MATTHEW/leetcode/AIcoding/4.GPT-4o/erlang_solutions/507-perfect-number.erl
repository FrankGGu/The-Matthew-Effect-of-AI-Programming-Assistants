-module(solution).
-export([check_perfect_number/1]).

-spec check_perfect_number(integer()) -> boolean().
check_perfect_number(Num) when Num > 1 ->
    Divisors = find_divisors(Num, 1, Num - 1, []),
    Sum = lists:sum(Divisors),
    Sum == Num;
check_perfect_number(_) ->
    false.

find_divisors(Num, Start, End, Divisors) when Start < End ->
    case Num rem Start of
        0 -> find_divisors(Num, Start + 1, End, [Start | Divisors]);
        _ -> find_divisors(Num, Start + 1, End, Divisors)
    end;
find_divisors(_, _, _, Divisors) -> Divisors.
