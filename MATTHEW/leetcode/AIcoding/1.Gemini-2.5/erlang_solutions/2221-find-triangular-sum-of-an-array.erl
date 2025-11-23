-module(solution).
-export([triangular_sum/1]).

triangular_sum([X]) -> X;
triangular_sum(Nums) -> triangular_sum(make_next_list(Nums)).

make_next_list([_]) -> [];
make_next_list([A, B | Rest]) -> [(A + B) rem 10 | make_next_list([B | Rest])].