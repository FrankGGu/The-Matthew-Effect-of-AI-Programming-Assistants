-module(remove_digit_from_number_to_maximize_result).
-export([remove_one_digit/1]).

remove_one_digit(Number) ->
    List = lists:seq(0, length(Number) - 1),
    Max = lists:max([list_to_integer(lists:sublist(Number, I, 1) ++ lists:sublist(Number, I+1, length(Number)-I)) || I <- List]),
    lists:flatten(lists:split(Max, Number)).

list_to_integer(List) ->
    list_to_integer(List, 0).

list_to_integer([], Acc) ->
    Acc;
list_to_integer([H | T], Acc) ->
    list_to_integer(T, Acc * 10 + (H - $0)).