-module(shuffle_string).
-export([restoreString/2]).

restoreString(S, Indices) ->
    restoreString(S, Indices, []).

restoreString([], [], Acc) ->
    list_to_binary(lists:reverse(Acc));
restoreString([H|T], [I|IT], Acc) ->
    restoreString(T, IT, [{I, H}|Acc]).

restoreString(S, Indices, Acc0) ->
    Len = length(S),
    Acc = lists:sort(fun({A,_}, {B,_}) -> A < B end, Acc0),
    restoreString2(Len, Acc, []).

restoreString2(0, _, Acc) ->
    list_to_binary(lists:reverse(Acc));
restoreString2(Len, [{_, H}|T], Acc) ->
    restoreString2(Len - 1, T, [H|Acc]).