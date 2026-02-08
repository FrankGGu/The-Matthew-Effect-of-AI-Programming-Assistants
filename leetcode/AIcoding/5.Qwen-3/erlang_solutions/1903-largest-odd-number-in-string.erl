-module(largest_odd_number_in_string).
-export([largest_odd_number/1]).

largest_odd_number(S) ->
    largest_odd_number(S, length(S), []).

largest_odd_number(_, 0, Acc) ->
    lists:reverse(Acc);
largest_odd_number(S, Pos, Acc) ->
    Char = string:at(S, Pos - 1),
    case (Char rem 2) of
        1 ->
            largest_odd_number(S, Pos - 1, [Char | Acc]);
        _ ->
            largest_odd_number(S, Pos - 1, Acc)
    end.