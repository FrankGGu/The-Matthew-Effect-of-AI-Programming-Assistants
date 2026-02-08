-module(reverse_string_ii).
-export([reverse_str/2]).

reverse_str(S, K) ->
    reverse_str(S, K, []).

reverse_str([], _, Acc) ->
    lists:flatten(lists:reverse(Acc));
reverse_str(S, K, Acc) ->
    {Take, Drop} = lists:split(min(K, length(S)), S),
    NewAcc = [lists:reverse(Take) | [lists:sublist(Drop, 1, min(K, length(Drop)))]],
    reverse_str(lists:sublist(Drop, min(K, length(Drop)) + 1, length(Drop) - min(K, length(Drop))), K, [NewAcc | Acc]).