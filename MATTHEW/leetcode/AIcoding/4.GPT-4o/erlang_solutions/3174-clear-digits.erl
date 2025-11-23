-module(solution).
-export([clear_digits/1]).

clear_digits(N) when is_integer(N) ->
    list_to_integer(clear_digits_helper(integer_to_list(N))).

clear_digits_helper([]) -> [];
clear_digits_helper([H | T]) when H =:= $0; H =:= $1; H =:= $2; H =:= $3; H =:= $4; H =:= $5; H =:= $6; H =:= $7; H =:= $8; H =:= $9 ->
    clear_digits_helper(T);
clear_digits_helper([H | T]) ->
    [H | clear_digits_helper(T)].