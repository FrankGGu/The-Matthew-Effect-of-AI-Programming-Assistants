-module(solution).
-export([crack_password/1]).

crack_password(Password) ->
    crack_password(Password, []).

crack_password([], Acc) ->
    lists:reverse(Acc);
crack_password([H|T], Acc) ->
    crack_password(T, [H + 1 | Acc]).