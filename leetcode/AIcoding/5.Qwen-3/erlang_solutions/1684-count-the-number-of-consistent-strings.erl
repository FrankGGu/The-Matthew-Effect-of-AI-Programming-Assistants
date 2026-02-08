-module(solution).
-export([count_consistent_strings/2]).

count_consistent_strings(Allowed, Words) ->
    AllowedSet = sets:from_list(Allowed),
    count_consistent(Words, AllowedSet, 0).

count_consistent([], _, Count) ->
    Count;
count_consistent([Word | Rest], AllowedSet, Count) ->
    case is_consistent(Word, AllowedSet) of
        true -> count_consistent(Rest, AllowedSet, Count + 1);
        false -> count_consistent(Rest, AllowedSet, Count)
    end.

is_consistent([], _) ->
    true;
is_consistent([Char | Rest], AllowedSet) ->
    case sets:is_element(Char, AllowedSet) of
        true -> is_consistent(Rest, AllowedSet);
        false -> false
    end.