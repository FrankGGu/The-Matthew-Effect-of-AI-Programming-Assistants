-module(stepping_numbers).
-export([count_stepping_numbers/2]).

count_stepping_numbers(Low, High) ->
    count_less_or_equal(High) - count_less_or_equal(Low - 1).

count_less_or_equal(N) ->
    Digits = integer_to_list(N),
    Length = length(Digits),
    count_stepping_numbers_helper(Digits, Length, true, 0).

count_stepping_numbers_helper([], _, true, Count) ->
    Count;
count_stepping_numbers_helper([], _, false, Count) ->
    Count.

count_stepping_numbers_helper([Digit | Rest], Length, IsExact, Count) ->
    DigitValue = list_to_integer([Digit]),

    case Length of
        1 ->
            Count + DigitValue + (case IsExact of true -> 0; false -> 0 end);
        _ ->
            NewCount =
                lists:foldl(
                    fun(I, Acc) ->
                        case IsExact of
                            true ->
                                if I < DigitValue ->
                                    Acc + count_remaining_stepping_numbers(Length - 1);
                                elseif I == DigitValue ->
                                    Acc + count_stepping_numbers_helper(Rest, Length - 1, true, 0);
                                else
                                    Acc
                                end;
                            false ->
                                Acc + count_remaining_stepping_numbers(Length - 1)
                        end
                    end,
                    Count,
                    lists:seq(0, 9)
                ),

            case IsExact of
                true ->

                  NewCount + (if DigitValue > 0 -> 0 else 0 end);
                false ->
                    NewCount
            end
    end.

count_remaining_stepping_numbers(Length) ->
    case Length of
        0 ->
            1;
        _ ->
            memo(Length)
    end.

memo(Length) ->
    case ets:lookup(stepping_numbers_memo, Length) of
        [] ->
            Result = calculate_remaining_stepping_numbers(Length),
            ets:insert(stepping_numbers_memo, {Length, Result}),
            Result;
        [{_, Result}] ->
            Result
    end.

calculate_remaining_stepping_numbers(Length) ->
    lists:foldl(
        fun(I, Acc) ->
            Acc + calculate_stepping_numbers(I, Length - 1)
        end,
        0,
        lists:seq(1, 9)
    ).

calculate_stepping_numbers(_, 0) ->
    1;
calculate_stepping_numbers(LastDigit, Length) ->
    case Length of
        0 ->
            1;
        _ ->
            NextDigits =
                lists:filter(
                    fun(D) ->
                        abs(D - LastDigit) == 1
                    end,
                    lists:seq(0, 9)
                ),

            lists:foldl(
                fun(D, Acc) ->
                    Acc + calculate_stepping_numbers(D, Length - 1)
                end,
                0,
                NextDigits
            )
    end.

start() ->
    ets:new(stepping_numbers_memo, [named_table, public, set]).

stop() ->
    ets:delete(stepping_numbers_memo).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

test() ->
    start(),
    [?assertEqual(11, count_stepping_numbers(0, 21)),
     ?assertEqual(2, count_stepping_numbers(10, 11)],
    stop().

-endif.