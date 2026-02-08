-module(solution).
-export([is_same_after_reversals/1]).

is_same_after_reversals(N) ->
    case N of
        0 -> true;
        _ -> N =:= reverse_number(reverse_number(N))
    end.

reverse_number(X) ->
    list_to_integer(string:reverse(integer_to_list(X))).