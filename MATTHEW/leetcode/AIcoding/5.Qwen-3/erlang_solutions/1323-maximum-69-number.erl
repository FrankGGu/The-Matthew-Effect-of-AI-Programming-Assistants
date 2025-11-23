-module(maximum_69_number).
-export([maximum699Number/1]).

maximum699Number(N) ->
    L = integer_to_list(N),
    Max = lists:max([list_to_integer(lists:sublist(L, I) ++ [$9 | lists:sublist(L, I+1, length(L)-I)]) || I <- lists:seq(1, length(L)), lists:nth(I, L) == $6]),
    Max.