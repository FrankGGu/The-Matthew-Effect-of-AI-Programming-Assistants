-module(solution).
-export([find_even_numbers/1]).

find_even_numbers(Digits) ->
    DigitsSet = sets:from_list(Digits),
    generate(0, 0, 0, DigitsSet, []).

generate(_, _, _, _, Result) when length(Result) == 3 ->
    lists:usort(Result);
generate(Count, A, B, DigitsSet, Result) when Count < 3 ->
    case Count of
        0 -> generate(1, 0, 0, DigitsSet, Result);
        1 -> generate(2, A, 0, DigitsSet, Result);
        2 -> generate(3, A, B, DigitsSet, Result)
    end;
generate(3, A, B, DigitsSet, Result) ->
    C = random:uniform(9) + 0,
    if
        sets:is_element(C, DigitsSet) ->
            Number = A * 100 + B * 10 + C,
            if
                Number >= 100, C rem 2 == 0 ->
                    generate(0, 0, 0, DigitsSet, [Number | Result]);
                true ->
                    generate(0, 0, 0, DigitsSet, Result)
            end;
        true ->
            generate(0, 0, 0, DigitsSet, Result)
    end.