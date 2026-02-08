-module(solution).
-export([sum_of_number_and_reverse/1]).

sum_of_number_and_reverse(N) ->
    ReverseN = list_to_integer(lists:reverse(integer_to_list(N))),
    N + ReverseN =:= 2 * N.