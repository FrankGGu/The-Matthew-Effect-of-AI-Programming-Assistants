-module(solution).
-export([count_substrings/1]).

count_substrings(S) ->
    count_substrings(S, 0).

count_substrings([], Acc) ->
    Acc;
count_substrings([H|T], Acc) ->
    count_substrings(T, Acc + count_divisible(list_to_integer([H|T]), list_to_integer([H]))).

count_divisible(Num, LastDigit) ->
    case LastDigit of
        0 -> 0;
        _ ->
            case (Num rem LastDigit) == 0 of
                true -> 1;
                false -> 0
            end
    end.