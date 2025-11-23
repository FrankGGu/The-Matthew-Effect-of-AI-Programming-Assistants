-module(solution).
-export([countConsistentStrings/2]).

-spec countConsistentStrings(Allowed :: unicode:unicode_binary(), Words :: [unicode:unicode_binary()]) -> integer().
countConsistentStrings(Allowed, Words) ->
    AllowedSet = gb_sets:from_list(binary_to_list(Allowed)),
    count_consistent_strings_recursive(Words, AllowedSet, 0).

count_consistent_strings_recursive([], _AllowedSet, Count) ->
    Count;
count_consistent_strings_recursive([Word | Rest], AllowedSet, CurrentCount) ->
    case is_consistent(Word, AllowedSet) of
        true ->
            count_consistent_strings_recursive(Rest, AllowedSet, CurrentCount + 1);
        false ->
            count_consistent_strings_recursive(Rest, AllowedSet, CurrentCount)
    end.

is_consistent(Word, AllowedSet) ->
    is_consistent_chars(binary_to_list(Word), AllowedSet).

is_consistent_chars([], _AllowedSet) ->
    true;
is_consistent_chars([Char | Rest], AllowedSet) ->
    case gb_sets:is_member(Char, AllowedSet) of
        true ->
            is_consistent_chars(Rest, AllowedSet);
        false ->
            false
    end.