-module(reverse_string_ii).
-export([reverse_string/2]).

reverse_string(S, K) ->
    reverse_string_helper(S, K, 1, []).

reverse_string_helper([], _, _, Acc) ->
    lists:reverse(Acc);
reverse_string_helper(S, K, I, Acc) when I rem K == 0 ->
    [ReversePart | Rest] = split_at(K, S),
    reverse_string_helper(Rest, K, I + 1, [lists:reverse(ReversePart) | Acc]);
reverse_string_helper(S, K, I, Acc) ->
    [Part | Rest] = split_at(K, S),
    reverse_string_helper(Rest, K, I + 1, [Part | Acc]).

split_at(N, List) ->
    split_at(N, List, []).

split_at(0, List, Acc) ->
    [lists:reverse(Acc), List];
split_at(N, [H|T], Acc) ->
    split_at(N-1, T, [H|Acc]).