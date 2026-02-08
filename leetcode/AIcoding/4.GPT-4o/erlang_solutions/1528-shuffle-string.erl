-module(solution).
-export([restore_string/2]).

restore_string(S, Indices) ->
    Length = length(S),
    List = lists:duplicate(Length, '$undefined'),
    restore_string(S, Indices, List, 1).

restore_string(_, [], Acc, _) ->
    lists:map(fun(X) -> X end, Acc);
restore_string(S, [Idx | Rest], Acc, Pos) ->
    NewAcc = lists:replace(Acc, Idx + 1, list_to_tuple(S, Pos)),
    restore_string(S, Rest, NewAcc, Pos + 1).

list_to_tuple(S, Pos) ->
    lists:nth(Pos, S).