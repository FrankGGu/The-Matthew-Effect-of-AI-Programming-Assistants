-module(solution).
-export([maximum_number/2]).

maximum_number(Num, Change) ->
    NumList = integer_to_list(Num),
    Changed = mutate(NumList, Change, false),
    list_to_integer(Changed).

mutate([], _, _) ->
    [];
mutate([H | T], Change, Mutated) ->
    Digit = H - $0,
    ChangeDigit = lists:nth(Digit + 1, Change),
    if
        ChangeDigit > Digit andalso not Mutated ->
            [ChangeDigit | mutate(T, Change, true)];
        ChangeDigit >= Digit andalso Mutated ->
            [ChangeDigit | mutate(T, Change, true)];
        true ->
            [H | mutate(T, Change, Mutated)]
    end.