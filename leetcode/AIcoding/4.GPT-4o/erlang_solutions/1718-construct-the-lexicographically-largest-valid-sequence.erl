module solution.

-export([largest_valid_sequence/1]).

largest_valid_sequence(N) ->
    largest_valid_sequence(N, N, []).

largest_valid_sequence(0, 0, Acc) ->
    lists:reverse(Acc);
largest_valid_sequence(A, B, Acc) when A > 0, B > 0 ->
    largest_valid_sequence(A - 1, B, [A | Acc]);
largest_valid_sequence(A, B, Acc) when A > 0, B =:= 0 ->
    largest_valid_sequence(A - 1, B, [A | Acc]);
largest_valid_sequence(A, B, Acc) when A =:= 0, B > 0 ->
    largest_valid_sequence(A, B - 1, [B | Acc]).