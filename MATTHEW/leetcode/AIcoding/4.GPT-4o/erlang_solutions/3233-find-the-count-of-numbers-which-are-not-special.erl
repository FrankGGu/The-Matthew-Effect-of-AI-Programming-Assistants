-module(solution).
-export([count_special_numbers/1]).

count_special_numbers(N) ->
    count(N, 1).

count(N, C) when C > N -> 
    0;
count(N, C) -> 
    IsSpecial = special(C),
    SpecialCount = if IsSpecial -> 1; true -> 0 end,
    SpecialCount + count(N, C + 1).

special(N) ->
    case N rem 10 of
        0 -> true;
        1 -> true;
        2 -> true;
        3 -> true;
        4 -> true;
        5 -> true;
        6 -> true;
        7 -> true;
        8 -> true;
        9 -> true;
        _ -> false
    end.