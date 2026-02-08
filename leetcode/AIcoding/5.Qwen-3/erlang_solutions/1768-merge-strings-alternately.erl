-module(merge_strings_alternately).
-export([mergeAlternately/2]).

mergeAlternately(S1, S2) ->
    merge(S1, S2, []).

merge([], [], Acc) ->
    lists:reverse(Acc);
merge([H|T], [], Acc) ->
    merge([], [], [H | Acc ++ T]);
merge([], [H|T], Acc) ->
    merge([], [], [H | Acc ++ T]);
merge([H1|T1], [H2|T2], Acc) ->
    merge(T1, T2, [H2, H1 | Acc]).