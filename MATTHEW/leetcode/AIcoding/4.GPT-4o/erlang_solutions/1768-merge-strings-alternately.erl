-module(merge_strings_alternately).
-export([merge/2]).

merge(S1, S2) ->
    merge_helper(S1, S2, []).

merge_helper([], [], Acc) ->
    lists:reverse(Acc);
merge_helper([], [H | T], Acc) ->
    merge_helper([], T, [H | Acc]);
merge_helper([H | T], [], Acc) ->
    merge_helper(T, [], [H | Acc]);
merge_helper([H1 | T1], [H2 | T2], Acc) ->
    merge_helper(T1, T2, [H2, H1 | Acc]).