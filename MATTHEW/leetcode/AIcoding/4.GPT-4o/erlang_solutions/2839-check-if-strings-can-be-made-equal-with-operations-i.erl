-module(solution).
-export([check_strings_equal/2]).

check_strings_equal(S, T) ->
    lists:sort(S) =:= lists:sort(T).