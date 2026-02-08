-module(merge_strings_alternately).
-export([merge_alternately/2]).

merge_alternately(Word1, Word2) ->
    merge_alternately(Word1, Word2, []).

merge_alternately([], [], Acc) ->
    lists:reverse(Acc);
merge_alternately([], Word2, Acc) ->
    lists:reverse(lists:concat([lists:reverse(Acc), Word2]));
merge_alternately(Word1, [], Acc) ->
    lists:reverse(lists:concat([lists:reverse(Acc), Word1]));
merge_alternately([H1|T1], [H2|T2], Acc) ->
    merge_alternately(T1, T2, [H1, H2 | Acc]).