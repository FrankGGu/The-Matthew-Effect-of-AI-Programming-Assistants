-module(solution).
-export([sum_of_multiples/1]).

sum_of_multiples(N) ->
    sum_multiples_recursive(1, N, 0).

sum_multiples_recursive(Current, N, Acc) when Current > N ->
    Acc;
sum_multiples_recursive(Current, N, Acc) ->
    NewAcc = if
                 (Current rem 3 == 0) orelse (Current rem 5 == 0) orelse (Current rem 7 == 0) ->
                     Acc + Current;
                 true ->
                     Acc
             end,
    sum_multiples_recursive(Current + 1, N, NewAcc).