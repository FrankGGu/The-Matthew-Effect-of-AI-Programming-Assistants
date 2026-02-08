-module(solution).
-export([sum_subseq_widths/1]).

sum_subseq_widths(Numbers) ->
    Sorted = lists:sort(Numbers),
    Length = length(Sorted),
    lists:foldl(fun(X, Acc) -> Acc + X * (Length - 1 - lists:position(X, Sorted)) - X * lists:position(X, Sorted) end, 0, Sorted) rem (1 bsl 32).