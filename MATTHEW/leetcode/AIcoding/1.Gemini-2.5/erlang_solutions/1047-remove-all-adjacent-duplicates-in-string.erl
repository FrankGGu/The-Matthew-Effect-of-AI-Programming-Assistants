-module(solution).
-export([remove_duplicates/1]).

remove_duplicates(S) ->
    remove_duplicates_acc(S, []).

remove_duplicates_acc([], Acc) ->
    lists:reverse(Acc);
remove_duplicates_acc([H|T], [H|AccTail]) ->
    remove_duplicates_acc(T, AccTail);
remove_duplicates_acc([H|T], Acc) ->
    remove_duplicates_acc(T, [H|Acc]).