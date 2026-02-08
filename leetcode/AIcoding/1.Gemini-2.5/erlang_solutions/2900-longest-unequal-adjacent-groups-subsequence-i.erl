-module(solution).
-export([longest_unequal_adjacent_groups_subsequence/2]).

-spec longest_unequal_adjacent_groups_subsequence(Groups :: [integer()], Nums :: [integer()]) -> [integer()].
longest_unequal_adjacent_groups_subsequence(Groups, Nums) ->
    longest_unequal_adjacent_groups_subsequence_impl(Groups, Nums, [], undefined).

longest_unequal_adjacent_groups_subsequence_impl([], _Nums, Acc, _LastGroup) ->
    lists:reverse(Acc);
longest_unequal_adjacent_groups_subsequence_impl([Group | RestGroups], [Num | RestNums], Acc, undefined) ->
    longest_unequal_adjacent_groups_subsequence_impl(RestGroups, RestNums, [Num | Acc], Group);
longest_unequal_adjacent_groups_subsequence_impl([Group | RestGroups], [Num | RestNums], Acc, LastGroup) ->
    if
        Group /= LastGroup ->
            longest_unequal_adjacent_groups_subsequence_impl(RestGroups, RestNums, [Num | Acc], Group);
        true ->
            longest_unequal_adjacent_groups_subsequence_impl(RestGroups, RestNums, Acc, LastGroup)
    end.