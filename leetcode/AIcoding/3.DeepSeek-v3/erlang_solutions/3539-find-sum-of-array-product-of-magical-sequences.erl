-module(solution).
-export([sum_of_array_product/1]).

sum_of_array_product(Nums) ->
    sum_of_array_product(Nums, 0).

sum_of_array_product([], Acc) -> Acc;
sum_of_array_product([H|T], Acc) ->
    sum_of_array_product(T, Acc + H * product(T)).

product([]) -> 1;
product([H|T]) -> H * product(T).