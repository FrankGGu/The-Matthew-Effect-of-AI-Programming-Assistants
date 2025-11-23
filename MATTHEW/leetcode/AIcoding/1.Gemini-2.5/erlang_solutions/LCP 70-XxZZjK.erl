-module(solution).
-export([removeDuplicates/1]).

removeDuplicates(S) ->
    lists:reverse(remove_duplicates_acc(S, [])).

remove_duplicates_acc([], Acc) ->
    Acc;
remove_duplicates_acc([H|T], []) ->
    remove_duplicates_acc(T, [H]);
remove_duplicates_acc([H|T], [H|AccT]) ->
    remove_duplicates_acc(T, AccT);
remove_duplicates_acc([H|T], Acc) ->
    remove_duplicates_acc(T, [H|Acc]).