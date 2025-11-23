-module(largest_3_same_digit_number).
-export([largest_3_samedigit_number/1]).

largest_3_samedigit_number(Str) ->
    Max = -1,
    largest_3_samedigit_number(Str, 0, Max).

largest_3_samedigit_number([], _, Max) ->
    if
        Max == -1 -> "";
        true -> integer_to_list(Max)
    end;

largest_3_samedigit_number([C | T], Index, Max) ->
    if
        Index + 2 < length(Str) ->
            D1 = lists:nth(Index + 1, Str),
            D2 = lists:nth(Index + 2, Str),
            if
                C == D1 andalso D1 == D2 ->
                    Num = list_to_integer([C, D1, D2]),
                    NewMax = max(Max, Num),
                    largest_3_samedigit_number(T, Index + 1, NewMax);
                true ->
                    largest_3_samedigit_number(T, Index + 1, Max)
            end;
        true ->
            largest_3_samedigit_number(T, Index + 1, Max)
    end.