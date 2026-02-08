-module(solution).
-export([smallest_trimmed_numbers/2]).

smallest_trimmed_numbers(Numbers, Queries) ->
    Lists = lists:map(fun({Num, K}) -> {Num, trim(Num, K)} end, lists:zip(Numbers, Queries)),
    Sorted = lists:sort(fun({_, Trimmed1}, {_, Trimmed2}) -> Trimmed1 < Trimmed2 orelse (Trimmed1 =:= Trimmed2 andalso element(1, {_, Trimmed1}) < element(1, {_, Trimmed2})) end, Lists),
    lists:map(fun({Num, _}) -> Num end, Sorted).

trim(Num, K) ->
    S = integer_to_list(Num),
    Trimmed = lists:sublist(S, length(S) - K),
    list_to_integer(Trimmed).