-spec is_anagram(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
is_anagram(S, T) ->
    case length(S) =:= length(T) of
        false -> false;
        true ->
            SortedS = lists:sort(unicode:characters_to_list(S)),
            SortedT = lists:sort(unicode:characters_to_list(T)),
            SortedS =:= SortedT
    end.