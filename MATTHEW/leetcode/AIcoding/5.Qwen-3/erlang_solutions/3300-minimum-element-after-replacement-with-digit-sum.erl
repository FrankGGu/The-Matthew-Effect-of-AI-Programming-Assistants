-module(min_element_after_replacement).
-export([min_element/1]).

min_element(Nums) ->
    lists:min([replace(N) || N <- Nums]).

replace(N) ->
    Sum = digit_sum(N),
    if
        Sum < N -> Sum;
        true -> N
    end.

digit_sum(N) ->
    digit_sum(N, 0).

digit_sum(0, Acc) ->
    Acc;
digit_sum(N, Acc) ->
    digit_sum(N div 10, Acc + (N rem 10)).