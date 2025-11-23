-module(solution).
-export([nextGreaterNumericallyBalancedNumber/1]).

nextGreaterNumericallyBalancedNumber(N) ->
    BalancedNumbers = generate_balanced_numbers(),
    SortedBalancedNumbers = lists:sort(BalancedNumbers),
    find_next_greater(N, SortedBalancedNumbers).

generate_balanced_numbers() ->
    MaxTotalDigits = 10,
    dfs_generate(1, [], 0, MaxTotalDigits, []).

dfs_generate(Digit, ChosenDigits, CurrentNumDigits, MaxTotalDigits, Acc) ->
    if Digit > 9 ->
        if CurrentNumDigits > 0 ->
            DigitsList = lists:sort(lists:flatmap(fun(D) -> lists:duplicate(D, D) end, ChosenDigits)),
            Num = list_to_integer(DigitsList),
            [Num | Acc];
        true ->
            Acc
        end;
    true ->
        Acc1 = dfs_generate(Digit + 1, ChosenDigits, CurrentNumDigits, MaxTotalDigits, Acc),

        if CurrentNumDigits + Digit =< MaxTotalDigits ->
            NewChosenDigits = [Digit | ChosenDigits],
            NewNumDigits = CurrentNumDigits + Digit,
            dfs_generate(Digit + 1, NewChosenDigits, NewNumDigits, MaxTotalDigits, Acc1);
        true ->
            Acc1
        end
    end.

find_next_greater(_N, []) ->
    error(no_next_greater_balanced_number);
find_next_greater(N, [H | T]) ->
    if H > N ->
        H;
    true ->
        find_next_greater(N, T)
    end.