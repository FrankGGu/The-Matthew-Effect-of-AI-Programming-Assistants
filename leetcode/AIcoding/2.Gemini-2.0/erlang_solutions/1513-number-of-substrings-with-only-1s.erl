-module(solution).
-export([num_sub_strings/1]).

num_sub_strings(S) ->
    num_sub_strings_helper(S, 0, 0).

num_sub_strings_helper([], Acc, Count) ->
    Acc;
num_sub_strings_helper([$1|T], Acc, Count) ->
    num_sub_strings_helper(T, Acc + Count + 1, Count + 1);
num_sub_strings_helper([_|T], Acc, _) ->
    num_sub_strings_helper(T, Acc, 0).