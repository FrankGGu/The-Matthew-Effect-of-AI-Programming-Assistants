-module(solution).
-export([divide_string/2]).

divide_string(S, K) ->
    divide_string(S, K, []).

divide_string([], _, Acc) ->
    lists:reverse(Acc);
divide_string(S, K, Acc) ->
    Group = lists:sublist(S, K),
    divide_string(lists:nthtail(K, S), K, [Group | Acc]).