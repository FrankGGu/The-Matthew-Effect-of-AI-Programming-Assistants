-module(solution).
-export([number_of_powerful_integers/3]).

number_of_powerful_integers(Start, Finish, Limit) ->
    StartStr = integer_to_list(Start),
    FinishStr = integer_to_list(Finish),
    LenStart = length(StartStr),
    LenFinish = length(FinishStr),
    count(LenStart, LenFinish, StartStr, FinishStr, Limit, 0).

count(Len, Len, StartStr, FinishStr, Limit, Acc) ->
    Min = list_to_integer(StartStr),
    Max = list_to_integer(FinishStr),
    count_powerful(Min, Max, Limit, Acc);
count(Len, MaxLen, _StartStr, _FinishStr, Limit, Acc) when Len < MaxLen ->
    Min = pow(10, Len - 1),
    Max = pow(10, Len) - 1,
    NewAcc = count_powerful(Min, Max, Limit, Acc),
    count(Len + 1, MaxLen, "", "", Limit, NewAcc).

count_powerful(Min, Max, Limit, Acc) ->
    case Max < Min of
        true -> Acc;
        false ->
            Count = count_powerful_numbers(Min, Max, Limit),
            Acc + Count
    end.

count_powerful_numbers(Min, Max, Limit) ->
    DigitsMin = integer_to_list(Min),
    DigitsMax = integer_to_list(Max),
    Len = length(DigitsMin),
    count_powerful_numbers(Len, DigitsMin, DigitsMax, Limit, 0).

count_powerful_numbers(0, _DigitsMin, _DigitsMax, _Limit, Acc) -> Acc;
count_powerful_numbers(Len, DigitsMin, DigitsMax, Limit, Acc) ->
    case Len =:= length(DigitsMin) of
        true ->
            MinDigit = list_to_integer([hd(DigitsMin)]),
            MaxDigit = list_to_integer([hd(DigitsMax)]),
            count_digits(MinDigit, MaxDigit, tl(DigitsMin), tl(DigitsMax), Limit, Len - 1, Acc);
        false ->
            count_digits(0, 9, [], [], Limit, Len - 1, Acc)
    end.

count_digits(MinD, MaxD, RestMin, RestMax, Limit, RemLen, Acc) ->
    lists:foldl(fun(D, Sum) ->
        case D =< Limit of
            true ->
                case RemLen =:= 0 of
                    true -> Sum + 1;
                    false ->
                        case {RestMin, RestMax} of
                            {[], []} ->
                                Sum + pow(Limit + 1, RemLen);
                            {[], _} ->
                                Sum + count_powerful_numbers(RemLen, [], RestMax, Limit, 0);
                            {_, []} ->
                                Sum + count_powerful_numbers(RemLen, RestMin, [], Limit, 0);
                            _ ->
                                Sum + count_powerful_numbers(RemLen, RestMin, RestMax, Limit, 0)
                        end
                end;
            false -> Sum
        end
    end, Acc, lists:seq(MinD, MaxD)).

pow(_Base, 0) -> 1;
pow(Base, Exp) -> Base * pow(Base, Exp - 1).