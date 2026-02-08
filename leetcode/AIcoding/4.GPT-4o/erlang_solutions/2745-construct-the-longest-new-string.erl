-module(solution).
-export([construct_longest_new_string/2]).

construct_longest_new_string(N, K) ->
    lists:duplicate(N, "a") ++ lists:duplicate(K, "b").