-module(solution).
-export([sort_jumbled/2]).

sort_jumbled(Mapping, Nums) ->
    F = fun(Num) ->
            Str = integer_to_list(Num),
            Mapped = lists:map(fun(C) -> 
                                Digit = C - $0,
                                M = lists:nth(Digit + 1, Mapping),
                                M + $0
                              end, Str),
            list_to_integer(Mapped)
        end,
    MappedNums = lists:map(fun(N) -> {F(N), N} end, Nums),
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A =< B end, MappedNums),
    [Num || {_, Num} <- Sorted].