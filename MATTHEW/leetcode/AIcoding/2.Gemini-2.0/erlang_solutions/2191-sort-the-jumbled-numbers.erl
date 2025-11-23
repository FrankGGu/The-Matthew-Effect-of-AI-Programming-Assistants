-module(jumbled_numbers).
-export([sort_jumbled/2]).

sort_jumbled(Mapping, Numbers) ->
    MappedNumbers = lists:map(fun(N) -> {map_number(N, Mapping), N} end, Numbers),
    SortedMappedNumbers = lists:keysort(1, MappedNumbers),
    [N || {_Mapped, N} <- SortedMappedNumbers].

map_number(N, Mapping) ->
    Digits = integer_to_list(N),
    MappedDigits = lists:map(fun(D) -> Mapping[list_to_integer([D]) - $0 + 1] end, Digits),
    list_to_integer(MappedDigits).