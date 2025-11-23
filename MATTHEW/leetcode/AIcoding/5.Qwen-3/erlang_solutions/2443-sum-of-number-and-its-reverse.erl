-module(solution).
-export([sum_of_number_and_reverse/1]).

sum_of_number_and_reverse(N) ->
    Reverse = reverse_number(N),
    N + Reverse.

reverse_number(0) ->
    0;
reverse_number(N) ->
    reverse_number(N, 0).

reverse_number(0, Acc) ->
    Acc;
reverse_number(N, Acc) ->
    reverse_number(N div 10, Acc * 10 + N rem 10).