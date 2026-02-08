-module(count_special_integers).
-export([count_special_integers/1]).

count_special_integers(N) ->
    count_special_integers(N, 0, []).

count_special_integers(0, Acc, _) ->
    Acc;
count_special_integers(N, Acc, Seen) ->
    Digits = integer_to_list(N),
    Len = length(Digits),
    count_below(Digits, 0, Seen) + Acc.

count_below(Digits, Index, Seen) ->
    case Index >= length(Digits) of
        true ->
            1;
        false ->
            Digit = list_to_integer([lists:nth(Index + 1, Digits)]),
            Sum = lists:foldl(
                fun(D, Acc0) ->
                    case D < Digit andalso not lists:member(D, Seen) of
                        true ->
                            Acc0 + count_remaining(length(Digits) - Index - 1, Seen ++ [D]);
                        false ->
                            Acc0
                    end
                end,
                0,
                lists:seq(0, 9)
            ),
            case lists:member(Digit, Seen) of
                true ->
                    Sum;
                false ->
                    case Index == length(Digits) - 1 of
                        true ->
                            Sum + 1;
                        false ->
                            Sum + count_below(Digits, Index + 1, Seen ++ [Digit])
                    end
            end
    end.

count_remaining(0, _) ->
    1;
count_remaining(Len, Seen) ->
    Available = 10 - length(Seen),
    lists:foldl(
        fun(_, Acc) ->
            Acc * (Available - 1)
        end,
        Available,
        lists:seq(1, Len - 1)
    ).