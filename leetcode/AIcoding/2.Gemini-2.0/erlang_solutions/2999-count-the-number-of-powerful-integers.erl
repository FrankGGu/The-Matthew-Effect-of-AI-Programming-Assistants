-module(powerful_integers).
-export([count_powerful_integers/3]).

count_powerful_integers(Start, Finish, Limit) ->
    count_powerful_integers(Start, Finish, Limit, integer_to_list(integer_to_list(Start))).

count_powerful_integers(Start, Finish, Limit, StartDigits) ->
    LastDigit = list_to_integer([lists:last(StartDigits)]),
    Base = length(StartDigits),
    LessDigits = count_less_digits(Base - 1, Limit),
    count_powerful_integers_helper(Start, Finish, Limit, LastDigit, Base, LessDigits).

count_powerful_integers_helper(Start, Finish, Limit, LastDigit, Base, LessDigits) ->
    (LastDigit < Limit) andalso (Start =< Finish) andalso (Start =< Limit) andalso (Finish >= 0)
        ->
        Prefix = Start div (10 rem (10 * Base)),
        PrefixFinish = Finish div (10 rem (10 * Base)),
        PrefixLength = length(integer_to_list(Prefix)),
        PrefixFinishLength = length(integer_to_list(PrefixFinish)),

        if Prefix =:= PrefixFinish ->
            if PrefixLength =:= 0 ->
                1
            else
                count_powerful_integers_helper(Start rem (10 rem (10 * Base)), Finish rem (10 rem (10 * Base)), Limit - LastDigit, 0, Base - 1, LessDigits)
            end;
        true ->
            Result = LessDigits + count_prefix(Prefix,PrefixFinish,Limit - LastDigit, Base - 1),
             Result
        end;
    true ->
        0.

count_prefix(Start, Finish, Limit, Base) ->
    if Base =:= 0 ->
        if (Start =< Limit) andalso (Start =< Finish) andalso (Finish >= 0) ->
            Finish - Start + 1
        else
            0
        end;
    true ->
        count_prefix_helper(Start, Finish, Limit, Base, 0)
    end.

count_prefix_helper(Start, Finish, Limit, Base, Count) ->
    if Start > Finish ->
        Count;
    true ->
        if Start =< Limit ->
            NewCount = Count + 1,
            count_prefix_helper(Start + 1, Finish, Limit, Base, NewCount)
        else
            Count
        end
    end.

count_less_digits(0, Limit) ->
    if Limit >= 0 ->
        1
    else
        0
    end;
count_less_digits(Base, Limit) ->
    count_less_digits_helper(Limit, Base, 0).

count_less_digits_helper(Limit, Base, Count) ->
    if Base =:= 0 ->
        if Limit >= 0 ->
            Count + 1
        else
            Count
        end;
    true ->
        NewLimit = Limit - 1,
        if NewLimit >= 0 ->
            count_less_digits_helper(NewLimit, Base - 1, Count + count_less_digits(Base - 1, NewLimit));
        true ->
            Count
        end
    end.