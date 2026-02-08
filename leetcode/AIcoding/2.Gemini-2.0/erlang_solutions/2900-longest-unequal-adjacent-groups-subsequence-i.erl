-module(longest_unequal_adjacent_groups_subsequence1).
-export([longest_unequal_adjacent_groups_subsequence/2]).

longest_unequal_adjacent_groups_subsequence(Words, Groups) ->
    longest_unequal_adjacent_groups_subsequence(Words, Groups, [], -1).

longest_unequal_adjacent_groups_subsequence([], [], Acc, _) ->
    lists:reverse(Acc);
longest_unequal_adjacent_groups_subsequence([Word|RestWords], [Group|RestGroups], Acc, LastGroup) ->
    case Group =/= LastGroup of
        true ->
            longest_unequal_adjacent_groups_subsequence(RestWords, RestGroups, [Word|Acc], Group);
        false ->
            longest_unequal_adjacent_groups_subsequence(RestWords, RestGroups, Acc, LastGroup)
    end.